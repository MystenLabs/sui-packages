module 0x9b47598f41c1f22d64f50aa7b0ce9be4e45143862b2709d4a326d9ef1b0d703f::claim {
    struct CLAIM has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        proofs: 0x2::table::Table<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>,
        orphans: vector<u64>,
        minted: u64,
        supply: u64,
        live: u64,
        open: bool,
        price: u64,
        pot_a: 0x2::balance::Balance<T0>,
        pot_b: 0x2::balance::Balance<T1>,
        acc_a: u128,
        acc_b: u128,
    }

    struct Claim has store, key {
        id: 0x2::object::UID,
        number: u64,
        vault: 0x2::object::ID,
        debt_a: u128,
        debt_b: u128,
    }

    struct Lent {
        vault: 0x2::object::ID,
        index: u64,
        proof: 0x2::object::ID,
    }

    struct VaultOpened has copy, drop {
        vault: 0x2::object::ID,
        pool: 0x2::object::ID,
        supply: u64,
    }

    struct Minted has copy, drop {
        claim: 0x2::object::ID,
        number: u64,
        vault: 0x2::object::ID,
        minter: address,
    }

    struct Burned has copy, drop {
        claim: 0x2::object::ID,
        number: u64,
        paid_a: u64,
        paid_b: u64,
        holder: address,
    }

    struct Donated has copy, drop {
        vault: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        live: u64,
    }

    struct Collected has copy, drop {
        vault: 0x2::object::ID,
        number: u64,
        amount_a: u64,
        amount_b: u64,
        holder: address,
    }

    public fun burn<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: Claim, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg1.vault == 0x2::object::uid_to_inner(&arg0.id), 3);
        let (v0, v1) = owed<T0, T1>(arg0, &arg1);
        let Claim {
            id     : v2,
            number : v3,
            vault  : _,
            debt_a : _,
            debt_b : _,
        } = arg1;
        let v7 = v2;
        0x2::object::delete(v7);
        0x1::vector::push_back<u64>(&mut arg0.orphans, v3);
        arg0.live = arg0.live - 1;
        let v8 = Burned{
            claim  : 0x2::object::uid_to_inner(&v7),
            number : v3,
            paid_a : v0,
            paid_b : v1,
            holder : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Burned>(v8);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot_a, v0), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.pot_b, v1), arg2))
    }

    public fun close<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>) {
        arg1.open = false;
    }

    public fun collect_pot<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut Claim, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg1.vault == 0x2::object::uid_to_inner(&arg0.id), 3);
        let (v0, v1) = owed<T0, T1>(arg0, arg1);
        arg1.debt_a = arg0.acc_a;
        arg1.debt_b = arg0.acc_b;
        let v2 = Collected{
            vault    : 0x2::object::uid_to_inner(&arg0.id),
            number   : arg1.number,
            amount_a : v0,
            amount_b : v1,
            holder   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Collected>(v2);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot_a, v0), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.pot_b, v1), arg2))
    }

    public fun donate<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        assert!(arg0.live > 0, 5);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        0x2::balance::join<T0>(&mut arg0.pot_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.pot_b, 0x2::coin::into_balance<T1>(arg2));
        let v2 = (arg0.live as u128);
        arg0.acc_a = arg0.acc_a + (v0 as u128) * 1000000000000 / v2;
        arg0.acc_b = arg0.acc_b + (v1 as u128) * 1000000000000 / v2;
        let v3 = Donated{
            vault    : 0x2::object::uid_to_inner(&arg0.id),
            amount_a : v0,
            amount_b : v1,
            live     : arg0.live,
        };
        0x2::event::emit<Donated>(v3);
    }

    fun init(arg0: CLAIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CLAIM>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"number"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"LP Claim #{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The right to the trading fees of a permanently locked Cetus liquidity position. The liquidity can never be withdrawn by anyone, including the issuer. Burning this NFT gives up the claim and donates its future fees to the remaining holders."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://goldnuggetsales.com/images/11-25-25%20TM%20RB%20M%20T%20California%20Natural%20Gold%20Nugget--45.jpg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://goldnuggetsales.com/images/11-25-25%20TM%20RB%20M%20T%20California%20Natural%20Gold%20Nugget--45.jpg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suivision.xyz/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://app.cetus.zone"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Prospector"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{number}"));
        let v5 = 0x2::display::new_with_fields<Claim>(&v0, v1, v3, arg1);
        0x2::display::update_version<Claim>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Claim>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun lend<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &Claim) : (0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof, Lent) {
        assert!(arg1.vault == 0x2::object::uid_to_inner(&arg0.id), 3);
        take<T0, T1>(arg0, arg1.number)
    }

    public fun lend_orphan<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: u64) : (0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof, Lent) {
        assert!(0x1::vector::contains<u64>(&arg1.orphans, &arg2), 6);
        take<T0, T1>(arg1, arg2)
    }

    public fun live<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.live
    }

    public fun mint<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        place_claim<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    entry fun mint_public<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T1>(&arg5) >= arg0.price, 7);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, 4294523696, 443600, arg9);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut v0, arg0.price, false, arg6);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v1);
        assert!(0x2::coin::value<T0>(&arg4) >= v2, 7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v2, arg9)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, v3, arg9)), v1);
        let v4 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg3, v0, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, 0x2::tx_context::sender(arg9));
        place_claim<T0, T1>(arg0, v4, arg7, arg8, arg9);
    }

    entry fun mint_with_sui<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T1>(&arg4) >= arg0.price, 7);
        assert!(arg5 > 0 && arg5 < arg0.price, 8);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, arg5, 79226673515401279992447579055, arg6);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)), v3);
        let v5 = 0x2::balance::value<T0>(&v4);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, 4294523696, 443600, arg9);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut v6, v5, true, arg6);
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v7);
        assert!(v8 == v5, 9);
        assert!(0x2::coin::value<T1>(&arg4) >= v9, 7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, v4, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v9, arg9)), v7);
        let v10 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg3, v6, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, 0x2::tx_context::sender(arg9));
        place_claim<T0, T1>(arg0, v10, arg7, arg8, arg9);
    }

    public fun minted<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.minted
    }

    public fun number(arg0: &Claim) : u64 {
        arg0.number
    }

    public fun open_vault<T0, T1>(arg0: &AdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = VaultOpened{
            vault  : 0x2::object::uid_to_inner(&v0),
            pool   : arg1,
            supply : arg2,
        };
        0x2::event::emit<VaultOpened>(v1);
        let v2 = Vault<T0, T1>{
            id      : v0,
            pool    : arg1,
            proofs  : 0x2::table::new<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(arg4),
            orphans : vector[],
            minted  : 0,
            supply  : arg2,
            live    : 0,
            open    : true,
            price   : arg3,
            pot_a   : 0x2::balance::zero<T0>(),
            pot_b   : 0x2::balance::zero<T1>(),
            acc_a   : 0,
            acc_b   : 0,
        };
        0x2::transfer::share_object<Vault<T0, T1>>(v2);
    }

    public fun orphans<T0, T1>(arg0: &Vault<T0, T1>) : &vector<u64> {
        &arg0.orphans
    }

    fun owed<T0, T1>(arg0: &Vault<T0, T1>, arg1: &Claim) : (u64, u64) {
        ((((arg0.acc_a - arg1.debt_a) / 1000000000000) as u64), (((arg0.acc_b - arg1.debt_b) / 1000000000000) as u64))
    }

    public fun pending<T0, T1>(arg0: &Vault<T0, T1>, arg1: &Claim) : (u64, u64) {
        owed<T0, T1>(arg0, arg1)
    }

    fun place_claim<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.open, 1);
        assert!(arg0.minted < arg0.supply, 2);
        let v0 = arg0.minted;
        arg0.minted = v0 + 1;
        arg0.live = arg0.live + 1;
        0x2::table::add<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.proofs, v0, arg1);
        let v1 = 0x2::object::new(arg4);
        let v2 = Minted{
            claim  : 0x2::object::uid_to_inner(&v1),
            number : v0,
            vault  : 0x2::object::uid_to_inner(&arg0.id),
            minter : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Minted>(v2);
        let v3 = Claim{
            id     : v1,
            number : v0,
            vault  : 0x2::object::uid_to_inner(&arg0.id),
            debt_a : arg0.acc_a,
            debt_b : arg0.acc_b,
        };
        0x2::kiosk::place<Claim>(arg2, arg3, v3);
    }

    public fun pot<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.pot_a), 0x2::balance::value<T1>(&arg0.pot_b))
    }

    public fun price<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.price
    }

    public fun restore<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof, arg2: Lent) {
        let Lent {
            vault : v0,
            index : v1,
            proof : v2,
        } = arg2;
        assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 3);
        assert!(0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&arg1) == v2, 4);
        0x2::table::add<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.proofs, v1, arg1);
    }

    public fun supply<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.supply
    }

    fun take<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) : (0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof, Lent) {
        let v0 = 0x2::table::remove<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.proofs, arg1);
        let v1 = Lent{
            vault : 0x2::object::uid_to_inner(&arg0.id),
            index : arg1,
            proof : 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&v0),
        };
        (v0, v1)
    }

    public fun vault_of(arg0: &Claim) : 0x2::object::ID {
        arg0.vault
    }

    // decompiled from Move bytecode v7
}


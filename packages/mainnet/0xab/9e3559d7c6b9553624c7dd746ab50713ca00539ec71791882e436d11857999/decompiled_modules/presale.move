module 0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::presale {
    struct Mint has store, key {
        id: 0x2::object::UID,
        is_active: bool,
        minting_price: u64,
        inner_hash: vector<u8>,
        profits: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CreditAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintPriceChanged has copy, drop {
        old_price: u64,
        new_price: u64,
        epoch_changed: u64,
    }

    public fun mint<T0>(arg0: &mut Mint, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::Degen<T0> {
        assert!(0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::is_authorized<T0>(&mut arg0.id), 2);
        assert!(arg0.is_active == true, 3);
        handle_payment(arg0, 1, arg3, arg4);
        0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::mint<T0>(&mut arg0.id, arg1, 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(), arg2, arg4)
    }

    public fun set_base_url<T0>(arg0: &0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::AdminCap, arg1: &mut Mint, arg2: 0x1::string::String) {
        0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::set_base_url<T0>(&mut arg1.id, arg2, arg0);
    }

    public fun authorize<T0>(arg0: &mut Mint, arg1: u32, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: &0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::AdminCap) {
        0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::authorize_app<T0>(&mut arg0.id, arg1, arg2, arg3, arg4, arg5);
    }

    public fun deauthorize<T0>(arg0: &mut Mint, arg1: &0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::AdminCap) {
        0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::revoke_auth<T0>(&mut arg0.id, arg1);
    }

    public fun get_minting_price(arg0: &Mint) : u64 {
        arg0.minting_price
    }

    fun handle_payment(arg0: &mut Mint, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.minting_price * arg1;
        assert!(v0 <= 0x2::coin::value<0x2::sui::SUI>(arg2), 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.profits, 0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        let v2 = Mint{
            id            : v0,
            is_active     : false,
            minting_price : 500000000,
            inner_hash    : 0x2::hash::blake2b256(&v1),
            profits       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Mint>(v2);
        let v3 = CreditAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CreditAdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun mintMany<T0>(arg0: &mut Mint, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : vector<0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::Degen<T0>> {
        assert!(0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::is_authorized<T0>(&mut arg0.id), 2);
        handle_payment(arg0, arg1, arg3, arg4);
        let v0 = 0x1::vector::empty<0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::Degen<T0>>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::Degen<T0>>(&mut v0, 0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::mint<T0>(&mut arg0.id, 0x1::string::utf8(b""), 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(), arg2, arg4));
            v1 = v1 + 1;
        };
        v0
    }

    public fun mintTo<T0>(arg0: &CreditAdminCap, arg1: &mut Mint, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &address, arg6: &mut 0x2::tx_context::TxContext) : 0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::Degen<T0> {
        assert!(0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::is_authorized<T0>(&mut arg1.id), 2);
        handle_payment(arg1, arg2, arg4, arg6);
        0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::mint<T0>(&mut arg1.id, 0x1::string::utf8(b""), 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(), arg3, arg6)
    }

    public fun set_minting_price(arg0: &0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::AdminCap, arg1: &mut Mint, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = MintPriceChanged{
            old_price     : arg1.minting_price,
            new_price     : arg2,
            epoch_changed : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<MintPriceChanged>(v0);
        arg1.minting_price = arg2;
    }

    public fun set_sale_active(arg0: &0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::AdminCap, arg1: &mut Mint, arg2: bool) {
        arg1.is_active = arg2;
    }

    public fun take_profits(arg0: &0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::AdminCap, arg1: &mut Mint, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.profits);
        assert!(v0 > 0, 1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.profits, v0, arg2)
    }

    public fun uid_mut(arg0: &0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen::AdminCap, arg1: &mut Mint) : &mut 0x2::object::UID {
        &mut arg1.id
    }

    // decompiled from Move bytecode v6
}


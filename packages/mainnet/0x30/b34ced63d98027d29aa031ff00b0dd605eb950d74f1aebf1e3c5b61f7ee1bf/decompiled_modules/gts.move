module 0x2beecdcba43f4ee412ce886216e0e8bb5d48486fa59a43222432f9f56c0592f8::gts {
    struct GTS has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<GTS>,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        minted: u64,
    }

    struct Redeemed has copy, drop {
        player: address,
        gts_burned: u64,
        sui_out: u64,
    }

    public(friend) fun burn(arg0: &mut Treasury, arg1: 0x2::coin::Coin<GTS>) {
        0x2::coin::burn<GTS>(&mut arg0.cap, arg1);
    }

    public(friend) fun mint(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<GTS> {
        let v0 = 1000000000000000 - arg0.minted;
        let v1 = if (arg1 > v0) {
            v0
        } else {
            arg1
        };
        arg0.minted = arg0.minted + v1;
        if (v1 == 0) {
            0x2::coin::zero<GTS>(arg2)
        } else {
            0x2::coin::mint<GTS>(&mut arg0.cap, v1, arg2)
        }
    }

    public fun total_supply(arg0: &Treasury) : u64 {
        0x2::coin::total_supply<GTS>(&arg0.cap)
    }

    public fun update_description(arg0: &Treasury, arg1: &mut 0x2::coin::CoinMetadata<GTS>, arg2: 0x1::string::String) {
        0x2::coin::update_description<GTS>(&arg0.cap, arg1, arg2);
    }

    public fun update_icon_url(arg0: &Treasury, arg1: &mut 0x2::coin::CoinMetadata<GTS>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<GTS>(&arg0.cap, arg1, arg2);
    }

    public fun floor_price_scaled(arg0: &Treasury) : u64 {
        let v0 = 0x2::coin::total_supply<GTS>(&arg0.cap);
        if (v0 == 0) {
            0
        } else {
            (((0x2::balance::value<0x2::sui::SUI>(&arg0.vault) as u128) * 1000000000 / (v0 as u128)) as u64)
        }
    }

    fun init(arg0: GTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTS>(arg0, 9, b"GTS", b"GTStar", b"Fair-launch mining token on Sui, backed by a SUI reserve. 1,000,000 max supply.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://minegts.fun/icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GTS>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = Treasury{
            id     : 0x2::object::new(arg1),
            cap    : v0,
            vault  : 0x2::balance::zero<0x2::sui::SUI>(),
            minted : 0,
        };
        0x2::transfer::share_object<Treasury>(v2);
    }

    public fun max_supply() : u64 {
        1000000000000000
    }

    public fun minted(arg0: &Treasury) : u64 {
        arg0.minted
    }

    public fun redeem(arg0: &mut Treasury, arg1: 0x2::coin::Coin<GTS>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 3
    }

    public fun vault_add(arg0: &mut Treasury, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        abort 3
    }

    public(friend) fun vault_take_all(arg0: &mut Treasury) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.vault)
    }

    public fun vault_value(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault)
    }

    // decompiled from Move bytecode v7
}


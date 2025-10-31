module 0x7cfd986096f8c1956b69ae41e5518dd521dc40fc09f6fa488142496f3dc3d545::ww {
    struct WW has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<WW>, arg1: 0x2::coin::Coin<WW>) {
        0x2::coin::burn<WW>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<WW>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WW> {
        0x2::coin::mint<WW>(arg0, arg1, arg2)
    }

    fun init(arg0: WW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WW>(arg0, 6, b"ww", b"WW", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1761926779520YFin.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WW>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<WW>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WW> {
        assert!(0x2::coin::total_supply<WW>(arg0) + 1000000000000000 <= 1000000000000000, 0);
        0x2::coin::mint<WW>(arg0, 1000000000000000, arg1)
    }

    // decompiled from Move bytecode v6
}


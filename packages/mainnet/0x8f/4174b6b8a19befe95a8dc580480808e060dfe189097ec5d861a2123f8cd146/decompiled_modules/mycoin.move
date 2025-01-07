module 0x8f4174b6b8a19befe95a8dc580480808e060dfe189097ec5d861a2123f8cd146::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: 0x2::coin::Coin<MYCOIN>) {
        0x2::coin::burn<MYCOIN>(arg0, arg1);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 2, b"MYCOIN", b"yinheli's coin", b"hello coin for learning move", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/235094")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MYCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


module 0xda96cb8f70ba6487f00c04e03d11a21023b7fcb184aab71497a8cba35706b261::suiki {
    struct SUIKI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIKI>, arg1: 0x2::coin::Coin<SUIKI>) {
        0x2::coin::burn<SUIKI>(arg0, arg1);
    }

    fun init(arg0: SUIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKI>(arg0, 9, b"suiki ", b"suiki", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKI>>(v1);
        0x2::coin::mint_and_transfer<SUIKI>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIKI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIKI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


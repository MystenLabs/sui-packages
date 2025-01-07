module 0x8df464d40934e18d599c843ffef18e78725f6e22d7b5d27bc8bb037fdc8ec378::chron {
    struct CHRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRON>(arg0, 9, b"CHRON", b"Chronite", b"Wen CHRON Lambo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHRON>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHRON>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x8a4291fd4c6e7ec328edcd2a905fc1c2c7992ad82c29c8ba86b147b896e9b2b5::POC {
    struct POC has drop {
        dummy_field: bool,
    }

    fun init(arg0: POC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POC>(arg0, 9, b"POC", b"POC", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POC>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<POC>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<POC>>(0x2::coin::mint<POC>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


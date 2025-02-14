module 0x14f403d4ce9f95f8c973bfbdeb49b9204fd9aa3e7cfa24d3c9c226f2a30b48de::PINETWORK {
    struct PINETWORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINETWORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINETWORK>(arg0, 9, b"PINETWORK", b"PINETWORK", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINETWORK>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PINETWORK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<PINETWORK>>(0x2::coin::mint<PINETWORK>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


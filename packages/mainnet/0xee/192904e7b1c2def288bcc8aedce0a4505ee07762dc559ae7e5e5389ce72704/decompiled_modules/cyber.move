module 0xee192904e7b1c2def288bcc8aedce0a4505ee07762dc559ae7e5e5389ce72704::cyber {
    struct CYBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBER>(arg0, 9, b"CYBER", b"CYBER", b"CYBER Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CYBER>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBER>>(v1);
    }

    // decompiled from Move bytecode v6
}


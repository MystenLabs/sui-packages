module 0xfa9c9d1bd86b18085d247ec426be59f6101dc2bdf200aeb46763b19c8e8050ab::worldc {
    struct WORLDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORLDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORLDC>(arg0, 2, b"WORLDC", b"Worldcash", b"World digital coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/file/d/156p5ibPJ4tQdYBHN3E93240VK9HaoT5g/view?usp=drive_link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WORLDC>(&mut v2, 50000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORLDC>>(v2, @0x9c9889886b86d2c6f80d8b46dda378c62ef49c03e2307b414c8a15c6f3ca5a65);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORLDC>>(v1);
    }

    // decompiled from Move bytecode v6
}


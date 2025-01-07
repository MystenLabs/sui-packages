module 0x39ea02acd7617d0765b7e4f7a49dabd1b43497f80e94f1d42ae78e6066eee6fc::suilama {
    struct SUILAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMA>(arg0, 6, b"SUILAMA", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://api.movepump.com/uploads/1000030596_8a14750351.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILAMA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILAMA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUILAMA>>(v2);
    }

    // decompiled from Move bytecode v6
}


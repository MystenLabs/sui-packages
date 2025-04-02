module 0xb4b3ed179fd7f9f8256b46698e7068d6ef9945f0bcb42033c9083481a539faa9::jht {
    struct JHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHT>(arg0, 9, b"JHT", b"cgyhio", b"dt6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c0cd012f422997bd22406690e38ce22cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


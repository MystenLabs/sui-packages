module 0x6492bb497d9bb650a9e5a2ac9aaf64bad609c4e57038c3ca62ec24df32bf4ddb::pai {
    struct PAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAI>(arg0, 6, b"PAI", b"Performance AI", b"An all-in-one platform combining powerful Al solutions to enhance, secure, and personalize user interactions with digital tools and services.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735571726174.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


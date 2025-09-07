module 0x51bd0eaed877751bf6ff000cbc0c63e88fc96368751e87395e4896cde2713395::Cartoon {
    struct CARTOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTOON>(arg0, 9, b"CARTOON", b"Cartoon", b"love cartoons", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G0KeizTXYAAX_x1?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CARTOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARTOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


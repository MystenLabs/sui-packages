module 0xc714d4c5cdc0b39c40132c4fac20578fed578b06eb242ca5f99f6c6a089767aa::Cults {
    struct CULTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULTS>(arg0, 9, b"CULTS", b"Cults", b"just be a cult. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzxUE0ZWgAAGHS2?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CULTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


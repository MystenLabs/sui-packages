module 0x7c1a4cf2be13b143352912f87adaaa3bb0525ad3fb051123ba840e8a07457caa::bbd {
    struct BBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBD>(arg0, 9, b"BBD", b"Barberdan", b"amazing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7891324108bafe08bd3951a10ed6ee86blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x6bb1303401e621a1fca61f3dfffda5016ca1000ec00a8dd97fb3f344f12e89cc::dyo {
    struct DYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYO>(arg0, 9, b"DYO", b"Girl you want", b"Can you find her", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/763ca1543207645ccced444ab180f948blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


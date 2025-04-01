module 0x1654caa4bf9a9d7929493340c7da6ff327da7df64e4bc9f17568e5f42c82d233::ms {
    struct MS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MS>(arg0, 9, b"MS", b"milasui", b"token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d3437fac6b5257380a9a81601e1d1deeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


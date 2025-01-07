module 0xb4d251906618ecdb7e4e92d81a301ce92639015872372318c33d3f8590c36a3::sauce {
    struct SAUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAUCE>(arg0, 9, b"Sauce", b"Sui Sauce", b"Fuel your SUI adventures with $Sauce, the innovative token powering the fun and user-friendly 7k.fun platform. Dive into a fast-growing ecosystem built on the rock-solid SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f1b71a202c5797fbe4687c39f744abecblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAUCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAUCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


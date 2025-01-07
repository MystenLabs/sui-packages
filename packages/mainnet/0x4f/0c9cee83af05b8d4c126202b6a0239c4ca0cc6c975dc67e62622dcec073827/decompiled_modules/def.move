module 0x4f0c9cee83af05b8d4c126202b6a0239c4ca0cc6c975dc67e62622dcec073827::def {
    struct DEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEF>(arg0, 9, b"DEF", b"Just a token", b"default token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/95bd3a914b78d1147ae87db5fb0d0fbeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


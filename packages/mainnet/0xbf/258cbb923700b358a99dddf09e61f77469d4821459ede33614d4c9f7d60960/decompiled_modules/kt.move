module 0xbf258cbb923700b358a99dddf09e61f77469d4821459ede33614d4c9f7d60960::kt {
    struct KT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KT>(arg0, 9, b"KT", b"kotik", b"Kotik motik", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0fcd958815f93b6d02ebdc87969f78c4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


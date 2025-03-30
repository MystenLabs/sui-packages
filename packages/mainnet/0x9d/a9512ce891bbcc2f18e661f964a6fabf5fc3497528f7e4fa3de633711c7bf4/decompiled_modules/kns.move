module 0x9da9512ce891bbcc2f18e661f964a6fabf5fc3497528f7e4fa3de633711c7bf4::kns {
    struct KNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNS>(arg0, 9, b"KNS", b"7KFUNNAMESERVICE", b"7K", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9f831b10a9439843ce9a65319d1f60a5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


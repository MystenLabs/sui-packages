module 0x559874d606e88ec94f97e0b5aac39fe2b2adbd6897a6b61e7fa39e25e0be14ed::bf {
    struct BF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BF>(arg0, 9, b"BF", b"bees and flowers", b"bees and flowers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f5f02fe429d1b6a0673192f4ef97b1e4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


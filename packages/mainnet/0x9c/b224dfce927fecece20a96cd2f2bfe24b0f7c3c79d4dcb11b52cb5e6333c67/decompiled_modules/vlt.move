module 0x9cb224dfce927fecece20a96cd2f2bfe24b0f7c3c79d4dcb11b52cb5e6333c67::vlt {
    struct VLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VLT>(arg0, 9, b"VLT", b"Vaulture ", b"token best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8bf1aa7b227d7f9b85e4bf98339d60d8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VLT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


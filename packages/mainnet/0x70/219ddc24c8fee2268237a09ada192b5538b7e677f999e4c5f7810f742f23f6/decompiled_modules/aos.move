module 0x70219ddc24c8fee2268237a09ada192b5538b7e677f999e4c5f7810f742f23f6::aos {
    struct AOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOS>(arg0, 6, b"AOS", b"Aquaman on Sui", b"The Number one Defender of the $SUI meme universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4413_037efd4397.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AOS>>(v1);
    }

    // decompiled from Move bytecode v6
}


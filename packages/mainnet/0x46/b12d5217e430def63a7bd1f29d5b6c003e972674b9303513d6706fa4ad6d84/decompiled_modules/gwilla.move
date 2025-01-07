module 0x46b12d5217e430def63a7bd1f29d5b6c003e972674b9303513d6706fa4ad6d84::gwilla {
    struct GWILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWILLA>(arg0, 6, b"GWILLA", b"THE GWILLA", b"$GWILLA - A Different Breed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gwilla_91bf8c6683.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}


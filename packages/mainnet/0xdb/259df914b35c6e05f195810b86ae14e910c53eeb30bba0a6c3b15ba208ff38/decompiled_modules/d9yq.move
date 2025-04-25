module 0xdb259df914b35c6e05f195810b86ae14e910c53eeb30bba0a6c3b15ba208ff38::d9yq {
    struct D9YQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: D9YQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D9YQ>(arg0, 6, b"D9yq", b"Hi-g", b"Yes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4643_61304af8dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D9YQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<D9YQ>>(v1);
    }

    // decompiled from Move bytecode v6
}


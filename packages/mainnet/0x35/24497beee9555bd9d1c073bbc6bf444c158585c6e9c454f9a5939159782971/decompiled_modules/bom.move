module 0x3524497beee9555bd9d1c073bbc6bf444c158585c6e9c454f9a5939159782971::bom {
    struct BOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOM>(arg0, 6, b"BOM", b"BOMBOM", b"BOMBOM IS A MEMECOIN THAT WILL EXPLODE ON THE SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000075191_bf63d7fac0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOM>>(v1);
    }

    // decompiled from Move bytecode v6
}


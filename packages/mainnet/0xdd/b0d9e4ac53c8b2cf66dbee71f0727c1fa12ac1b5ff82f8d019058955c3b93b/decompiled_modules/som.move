module 0xddb0d9e4ac53c8b2cf66dbee71f0727c1fa12ac1b5ff82f8d019058955c3b93b::som {
    struct SOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOM>(arg0, 6, b"SOM", b"Sui of Meme", b"No hesitate ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bz_Q_Tl_Zx_B_400x400_ae97567705.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOM>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x770b24778baecf2572ab8e4a26c3ec7ec49be7a1a44a0f635b16baabaee1f54e::sui6900 {
    struct SUI6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI6900>(arg0, 6, b"Sui6900", b"SUI6900", b"ticker: Sui6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/af8284e70a6abf864deb123ab05c8dc_aed1ed394a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI6900>>(v1);
    }

    // decompiled from Move bytecode v6
}


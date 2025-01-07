module 0xcac7214defd06a9308676570a3e35c765db7fedd3a0f2dad5620fe43857e7128::dgroot {
    struct DGROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGROOT>(arg0, 6, b"DGROOT", b"DANCING GROOT ON SUI", b"NEW GEM ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_0f9e8b88f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGROOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGROOT>>(v1);
    }

    // decompiled from Move bytecode v6
}


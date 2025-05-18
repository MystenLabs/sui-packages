module 0xe29cd0c0293ee6d1f675c5dc9be8249fde63d297a19c6ecd790b6e19965b2e8b::groke {
    struct GROKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROKE>(arg0, 6, b"GROKE", b"The GROKE", x"47726f6b652069732061206c6f6e676c792070656e6775696e2e20efbd9c202447524f4b45", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigjmmvzzm7sssgfyya4sfgwhwmg4dsu6axeb7ntbfiapunil7risu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GROKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


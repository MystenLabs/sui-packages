module 0x24d7ad5a628031aacee360d92c2face5330cfb6e7d48c0c5bfd7aabb6a1615b1::sonek {
    struct SONEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONEK>(arg0, 6, b"SONEK", b"Sonek On Sui", b"Sonek is a memecoin built on the Sui blockchain, designed to entertain and connect the global crypto community. Sonek combines humor, creativity, and advanced technology from the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241220_135011_51f20b7253.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONEK>>(v1);
    }

    // decompiled from Move bytecode v6
}


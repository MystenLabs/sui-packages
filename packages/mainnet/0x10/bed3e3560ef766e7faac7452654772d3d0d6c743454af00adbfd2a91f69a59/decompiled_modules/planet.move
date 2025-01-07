module 0x10bed3e3560ef766e7faac7452654772d3d0d6c743454af00adbfd2a91f69a59::planet {
    struct PLANET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANET>(arg0, 6, b"PLANET", b"Planet of Sui", b"Explore the $PLANET of Sui, where the skys no limit. A world of endless opportunities waiting to be discovered. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_67_882167a4e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLANET>>(v1);
    }

    // decompiled from Move bytecode v6
}


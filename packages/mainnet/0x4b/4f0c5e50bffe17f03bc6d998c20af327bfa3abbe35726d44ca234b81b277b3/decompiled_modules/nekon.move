module 0x4b4f0c5e50bffe17f03bc6d998c20af327bfa3abbe35726d44ca234b81b277b3::nekon {
    struct NEKON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKON>(arg0, 6, b"NEKON", b"NEKON FISH", b"JAPAN CAT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xf54a37595e16ca6f4f6ca742f29dbebfec737fc3_1_80ab3963c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEKON>>(v1);
    }

    // decompiled from Move bytecode v6
}


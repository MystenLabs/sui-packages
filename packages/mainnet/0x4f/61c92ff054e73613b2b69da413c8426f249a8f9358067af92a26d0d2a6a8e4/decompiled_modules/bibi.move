module 0x4f61c92ff054e73613b2b69da413c8426f249a8f9358067af92a26d0d2a6a8e4::bibi {
    struct BIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBI>(arg0, 6, b"BIBI", b"Bibi", b"BIBI is a purely community-driven organization that was built by the BIBI leaders, BIBI builders, and BIBI holders. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bibi_5a3b933eca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xfcf86dfefc5feae42d15dafa6dc50142a995d677130764500e66dd0bda77aba9::suipearl {
    struct SUIPEARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEARL>(arg0, 6, b"SUIPEARL", b"Sui Pearl", b"Sui Pearl Token, the hidden gem on sui Blockchain made of  fun and community spirit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1905_08fb429fd9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEARL>>(v1);
    }

    // decompiled from Move bytecode v6
}


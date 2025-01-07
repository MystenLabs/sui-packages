module 0x1a24a140f8a96742562f3cdaa16d750fb77b0834464637e51fa272e6af54267e::cv {
    struct CV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CV>(arg0, 6, b"CV", b"CyberVan", b"tesla Cyber Van for Musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tesla_sedang_kembangkan_cybervan_yang_siap_meluncur_pada_2026_fxv_e30ed5f675.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CV>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xcb9de5ee57d00288e21abe2eabc3996db61c18f434d35cdb029a567012467842::achu {
    struct ACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACHU>(arg0, 6, b"ACHU", b"Autistic Cat Hippo Underwater", b"Autistic Cat Hippo Underwater (ACHU) just launched on SUI and he's ready to make heads turn! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qmx24nwptcrk7gxk5j4xn6swegqrsdlcf2hbmtgqgmlqed_m2_Wp_PGJQ_73c_DR_Nen_23_63daef1092.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACHU>>(v1);
    }

    // decompiled from Move bytecode v6
}


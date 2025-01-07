module 0x7f353b5595a784b3ef43b34f165f7fa42abe126a89644d75ae302572c06066cc::poge {
    struct POGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POGE>(arg0, 6, b"POGE", b"Sui Poge", b"$POGE is a revolutionary meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_57_17c6d60d6d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POGE>>(v1);
    }

    // decompiled from Move bytecode v6
}


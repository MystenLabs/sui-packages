module 0x446e2e0004627adad44988ef44108dc0fb11fb2a4c822dfb2bbc91f80c338109::kfc {
    struct KFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFC>(arg0, 6, b"KFC", b"chickenball the wizard cat", b"https://x.com/KFC_ES/status/1843956978781135331", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zc_N_Bph_XAAA_Rucg_dd364ce09c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFC>>(v1);
    }

    // decompiled from Move bytecode v6
}


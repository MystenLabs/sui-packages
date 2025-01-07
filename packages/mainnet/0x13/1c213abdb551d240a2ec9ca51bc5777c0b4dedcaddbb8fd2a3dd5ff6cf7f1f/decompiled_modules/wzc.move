module 0x131c213abdb551d240a2ec9ca51bc5777c0b4dedcaddbb8fd2a3dd5ff6cf7f1f::wzc {
    struct WZC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WZC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WZC>(arg0, 6, b"WZC", b"WIZARDCAT", b"chickenball the wizardcat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zc_N_Bph_XAAA_Rucg_17ddea7ebf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WZC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WZC>>(v1);
    }

    // decompiled from Move bytecode v6
}


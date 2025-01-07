module 0x528038cd9c13ac513b9a39a9c6c26dbb8a93a8e46d5d8554d6c77537b17178b4::ceko {
    struct CEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEKO>(arg0, 6, b"CEKO", b"ceko token", b"ceko test project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lxz_m_ncxz_KJHGF_d78ea241be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}


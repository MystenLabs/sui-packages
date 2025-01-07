module 0xbe49e20e2099dd8f229891fe6b69e44f681c96e36df604ab1a04d1397e2ff3b3::pororosui {
    struct POROROSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POROROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POROROSUI>(arg0, 6, b"POROROSUI", b"Pororo", b"Pororo appeared. Everyone gather together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_e_e_e_i_removebg_preview_8def5c0aae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POROROSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POROROSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x1784ad29301ea5cfe42d8bddeaa41c4e12422c4c09856209cc6eec9aefe1b434::hawk {
    struct HAWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWK>(arg0, 6, b"HAWK", b"HawkSUI", b"Hawk soars in the sky, yearning for freedom!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ymz_Butj_W_400x400_765f36de76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAWK>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x62aea49457141353801707dd2a2f54f297f7a8f60e07ff5e0df54cd7b5787c6e::freemun {
    struct FREEMUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREEMUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREEMUN>(arg0, 6, b"Freemun", b"Mergen Freemun", b"The voice u heer in ur heed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_output_16cee6e6cc.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREEMUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREEMUN>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x62cc3ffd925d887773512d213522a32b10c91bf1b64bf63cec4ac1ba26589863::ciab {
    struct CIAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIAB>(arg0, 6, b"CIAB", b"cat in a bag", b"MY CAT LOVES MY LUNCH BAG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FB_IMG_1483742384828_476d4c4120.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIAB>>(v1);
    }

    // decompiled from Move bytecode v6
}


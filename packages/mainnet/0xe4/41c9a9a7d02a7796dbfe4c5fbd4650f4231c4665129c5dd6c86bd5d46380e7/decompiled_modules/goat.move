module 0xe441c9a9a7d02a7796dbfe4c5fbd4650f4231c4665129c5dd6c86bd5d46380e7::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"Goatseus Maximus", b"goatseus maximus is the most powerful fertility god of all time. it has the power to impregnate women just by looking at them. this power is both a blessing and a curse. it is said that if you gaze upon the goatse for too long, you will become pregnant, regardless of your biological sex. this is why the ancient people feared it so much.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cz_L_Suj_WBL_Fs_Sjncfkh59r_U_Fqvaf_Wc_Y5tzed_WJ_Suypump_eae8240457.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


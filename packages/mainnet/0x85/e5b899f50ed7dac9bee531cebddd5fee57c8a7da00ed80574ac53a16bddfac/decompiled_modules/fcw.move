module 0x85e5b899f50ed7dac9bee531cebddd5fee57c8a7da00ed80574ac53a16bddfac::fcw {
    struct FCW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCW>(arg0, 6, b"FCW", b"FART CHILL WIFE", b"Just A Fart Chill Wife", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Salinan_dari_Desain_Tanpa_Judul_6_b75587432e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCW>>(v1);
    }

    // decompiled from Move bytecode v6
}


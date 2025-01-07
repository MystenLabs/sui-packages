module 0xcfd9958aed04229792fb5361475386af941d3648a44cbd983ab7acef6e214c49::lan {
    struct LAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAN>(arg0, 9, b"LAN", b"Lanny", b"Lanny meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d48e9575-5089-4d22-846b-9208be7578ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


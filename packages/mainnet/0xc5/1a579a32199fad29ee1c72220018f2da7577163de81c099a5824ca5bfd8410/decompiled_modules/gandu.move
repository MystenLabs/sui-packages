module 0xc51a579a32199fad29ee1c72220018f2da7577163de81c099a5824ca5bfd8410::gandu {
    struct GANDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANDU>(arg0, 9, b"GANDU", b"Qazi gandu", b"Qazi gandu is me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15914682-5603-4e09-941b-790e4faafe1b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANDU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANDU>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xc76c95578249afdb606d9edc7c60162b160a714ab30842ef4b38e211f72ee3c2::yescoin {
    struct YESCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YESCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YESCOIN>(arg0, 9, b"YESCOIN", b"Yes", b"Yes coin is best meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18dfe0d4-26e7-478e-bbf9-5a728ef886f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YESCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YESCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


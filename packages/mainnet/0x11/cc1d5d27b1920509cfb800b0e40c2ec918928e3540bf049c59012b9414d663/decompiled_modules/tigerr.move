module 0x11cc1d5d27b1920509cfb800b0e40c2ec918928e3540bf049c59012b9414d663::tigerr {
    struct TIGERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGERR>(arg0, 9, b"TIGERR", b"Tiger", b"Crying Tiger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4768be96-0e5e-4326-bc8e-124015d93ae8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGERR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIGERR>>(v1);
    }

    // decompiled from Move bytecode v6
}


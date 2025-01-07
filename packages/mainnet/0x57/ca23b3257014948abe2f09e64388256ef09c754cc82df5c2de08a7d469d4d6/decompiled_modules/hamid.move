module 0x57ca23b3257014948abe2f09e64388256ef09c754cc82df5c2de08a7d469d4d6::hamid {
    struct HAMID has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMID>(arg0, 9, b"HAMID", b"Abdul ", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be5020cd-1c10-4b10-8e7d-2313ee82fcb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAMID>>(v1);
    }

    // decompiled from Move bytecode v6
}


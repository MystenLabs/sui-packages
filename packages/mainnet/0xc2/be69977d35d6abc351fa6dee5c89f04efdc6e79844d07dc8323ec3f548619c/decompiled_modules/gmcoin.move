module 0xc2be69977d35d6abc351fa6dee5c89f04efdc6e79844d07dc8323ec3f548619c::gmcoin {
    struct GMCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMCOIN>(arg0, 9, b"GMCOIN", b"GMC", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62478cdf-2d75-4feb-a3b6-37e5686a62b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x93cbc287b51352587609d2955a5ae35b5aacf28b434aea037db5ca7b28880783::dieekk {
    struct DIEEKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIEEKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIEEKK>(arg0, 9, b"DIEEKK", b"Siskdkd", b"Sksskkd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed0e299f-729c-4c14-b121-b4a2cb5c4f92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIEEKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIEEKK>>(v1);
    }

    // decompiled from Move bytecode v6
}


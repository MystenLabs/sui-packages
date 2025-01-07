module 0x6950ee80b8e7f85935bc36acccce0bdca27389c5c3a0a6aa8eba1accb8e6ba31::nampervn {
    struct NAMPERVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMPERVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMPERVN>(arg0, 9, b"NAMPERVN", b"NamPer", b"NamPerVn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58bbb4e4-fbd9-427e-b3e0-ad5e359906e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMPERVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAMPERVN>>(v1);
    }

    // decompiled from Move bytecode v6
}


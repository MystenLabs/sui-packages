module 0xe6c302be55d72e5bb9a24051ba5fd2f6bf95252ff12682dd2ff0f2281520e517::justinmoon {
    struct JUSTINMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTINMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTINMOON>(arg0, 9, b"JUSTINMOON", b"LABUBU", b"Your fear is my excitement :))", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d687baad-6bb3-4c15-91e4-e7da25faecf2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTINMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUSTINMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}


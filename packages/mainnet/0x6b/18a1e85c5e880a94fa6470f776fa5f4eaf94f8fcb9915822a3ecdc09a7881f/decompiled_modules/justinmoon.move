module 0x6b18a1e85c5e880a94fa6470f776fa5f4eaf94f8fcb9915822a3ecdc09a7881f::justinmoon {
    struct JUSTINMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTINMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTINMOON>(arg0, 9, b"JUSTINMOON", b"LABUBU", b"Your fear is my excitement :))", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4678d577-ce5d-4d83-a9b7-b556dc2ab05d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTINMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUSTINMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}


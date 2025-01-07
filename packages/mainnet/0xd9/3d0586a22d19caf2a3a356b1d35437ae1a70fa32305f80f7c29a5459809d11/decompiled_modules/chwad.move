module 0xd93d0586a22d19caf2a3a356b1d35437ae1a70fa32305f80f7c29a5459809d11::chwad {
    struct CHWAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHWAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHWAD>(arg0, 6, b"CHWAD", b"SUI CHWAD", x"546865206f6666696369616c206368776164206f66205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/closedai_5b067c5fd5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHWAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHWAD>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x9f559b8837f4becd5dd7dd5ae62020d0392a8dd1eb22c03f75f96dd5ac18763f::mhb {
    struct MHB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHB>(arg0, 9, b"MHB", b"Mujittapha", b"Mujittapha token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9762214f-0723-426b-a11f-6ce2579313c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MHB>>(v1);
    }

    // decompiled from Move bytecode v6
}


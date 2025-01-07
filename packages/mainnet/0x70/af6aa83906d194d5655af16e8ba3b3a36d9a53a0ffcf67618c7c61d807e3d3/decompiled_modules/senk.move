module 0x70af6aa83906d194d5655af16e8ba3b3a36d9a53a0ffcf67618c7c61d807e3d3::senk {
    struct SENK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENK>(arg0, 6, b"SENK", b"SENK SUI", b"Hey, I'm Senk, and I'm the coolest seal on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000113505_b26695bbad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENK>>(v1);
    }

    // decompiled from Move bytecode v6
}


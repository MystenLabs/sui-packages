module 0xd942cb0c70f49dc854d680ba4b419170384af745ec0514aa0ddabddd34d2dc59::suipu {
    struct SUIPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPU>(arg0, 6, b"SUIPU", b"Pepe Unchained", b"Your morning with Pepe Unchained. Pure bliss.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0660_2e21358d60.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPU>>(v1);
    }

    // decompiled from Move bytecode v6
}


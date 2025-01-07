module 0xade6df0a1f155d6e0e4ddd29738c212cd0b73f9f3e56deed94a7e6c33edb2219::HeaddressoftheHonored {
    struct HEADDRESSOFTHEHONORED has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEADDRESSOFTHEHONORED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEADDRESSOFTHEHONORED>(arg0, 0, b"COS", b"Headdress of the Honored", b"Here, nothing dies... all return to the sacred Aurah well...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Headdress_of_the_Honored.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEADDRESSOFTHEHONORED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEADDRESSOFTHEHONORED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


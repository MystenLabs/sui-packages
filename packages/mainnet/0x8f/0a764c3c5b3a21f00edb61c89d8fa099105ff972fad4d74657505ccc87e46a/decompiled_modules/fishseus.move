module 0x8f0a764c3c5b3a21f00edb61c89d8fa099105ff972fad4d74657505ccc87e46a::fishseus {
    struct FISHSEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHSEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHSEUS>(arg0, 6, b"Fishseus", b"Fishseus Maximus", b"First AI launched token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fishmaximus_14b682791d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHSEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHSEUS>>(v1);
    }

    // decompiled from Move bytecode v6
}


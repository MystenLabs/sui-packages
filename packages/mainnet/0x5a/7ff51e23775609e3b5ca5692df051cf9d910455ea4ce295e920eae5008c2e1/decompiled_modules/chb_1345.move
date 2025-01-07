module 0x5a7ff51e23775609e3b5ca5692df051cf9d910455ea4ce295e920eae5008c2e1::chb_1345 {
    struct CHB_1345 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHB_1345, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHB_1345>(arg0, 9, b"CHB_1345", b"Duck", b"To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53bf7c6c-002a-4d4d-8608-a244d7197ef4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHB_1345>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHB_1345>>(v1);
    }

    // decompiled from Move bytecode v6
}


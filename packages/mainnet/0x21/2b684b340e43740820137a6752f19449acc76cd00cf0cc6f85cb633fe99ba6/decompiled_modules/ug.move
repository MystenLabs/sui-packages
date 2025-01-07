module 0x212b684b340e43740820137a6752f19449acc76cd00cf0cc6f85cb633fe99ba6::ug {
    struct UG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UG>(arg0, 9, b"UG", b"Outfits ", b"Got it in a bag ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74fe04e7-2943-47e0-b221-805381c7302a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UG>>(v1);
    }

    // decompiled from Move bytecode v6
}


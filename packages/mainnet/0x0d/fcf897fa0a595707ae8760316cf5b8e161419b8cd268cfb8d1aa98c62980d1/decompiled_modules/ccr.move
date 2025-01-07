module 0xdfcf897fa0a595707ae8760316cf5b8e161419b8cd268cfb8d1aa98c62980d1::ccr {
    struct CCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCR>(arg0, 9, b"CCR", b"Citrus", b"Sour and full of flavor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da63415d-79fd-4368-976b-e735a66e8fac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCR>>(v1);
    }

    // decompiled from Move bytecode v6
}


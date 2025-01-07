module 0x35d2ae832face1b77e7f1c416d4e72f0d1fd21af601c684ec4ae93cd7d04e3e4::x_boom {
    struct X_BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: X_BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X_BOOM>(arg0, 9, b"X_BOOM", b"X Boom", b"Way To Change ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eddf4941-f39b-4014-9894-52b21f24f3af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X_BOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X_BOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}


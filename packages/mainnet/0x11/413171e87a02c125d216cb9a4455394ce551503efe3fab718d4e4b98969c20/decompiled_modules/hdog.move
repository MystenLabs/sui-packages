module 0x11413171e87a02c125d216cb9a4455394ce551503efe3fab718d4e4b98969c20::hdog {
    struct HDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDOG>(arg0, 9, b"HDOG", b"Hells Dog", b"Who let the dogs out??", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/114aaadd-74c3-4ba8-be18-5cb8394b0bb9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x1d7612cbba18e029c4733e01f04b3fe654133fdc84ac1faba5aac3f32af6e3a3::flow {
    struct FLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOW>(arg0, 9, b"FLOW", b"Flow", b"Time Flow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/237594d4-235f-4b8a-a5a0-4c92763d0e53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}


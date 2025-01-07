module 0xe6f0c238578cbe7268c9d6dd2dd8ec7c6268ade7196bc2a18d19e9bc4b36b200::chihu {
    struct CHIHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIHU>(arg0, 9, b"CHIHU", b"Chihuhu", b"Chihuhu Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b80a71cc-9302-49ff-b55f-f442f2265dcb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIHU>>(v1);
    }

    // decompiled from Move bytecode v6
}


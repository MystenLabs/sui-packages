module 0x732dbc37b2d9c0b5f2e3a7217b959ab2547ddf2c0c36b0f36d36e55466205a89::trex {
    struct TREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREX>(arg0, 9, b"TREX", b" T-RexToke", b"Stomp your way through crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7d4f760-d52f-40a6-b435-1185e419777d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREX>>(v1);
    }

    // decompiled from Move bytecode v6
}


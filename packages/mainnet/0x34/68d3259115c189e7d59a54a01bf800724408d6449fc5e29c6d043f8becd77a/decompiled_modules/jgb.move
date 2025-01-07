module 0x3468d3259115c189e7d59a54a01bf800724408d6449fc5e29c6d043f8becd77a::jgb {
    struct JGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JGB>(arg0, 9, b"JGB", b"Pepepips", b"Pepepips is a coin set to fly during bullrun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7cc8a738-993e-4196-858d-45a2615ab75e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JGB>>(v1);
    }

    // decompiled from Move bytecode v6
}


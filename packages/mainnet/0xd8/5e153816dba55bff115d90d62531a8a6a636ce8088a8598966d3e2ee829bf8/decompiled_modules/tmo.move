module 0xd85e153816dba55bff115d90d62531a8a6a636ce8088a8598966d3e2ee829bf8::tmo {
    struct TMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMO>(arg0, 9, b"TMO", b"tomo", b"start with barn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d1f9c39-e46e-45a7-9d7b-c3bb737ef2b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMO>>(v1);
    }

    // decompiled from Move bytecode v6
}


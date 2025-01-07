module 0x43ac11af15288e994f4cf5db8d8910818bc97c711259092a1dd1da06d2637ea1::jekdb {
    struct JEKDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEKDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEKDB>(arg0, 9, b"JEKDB", b"hendb", b"dhowod", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9838912a-bd4a-429f-9ffe-a23a36476e65.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEKDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEKDB>>(v1);
    }

    // decompiled from Move bytecode v6
}


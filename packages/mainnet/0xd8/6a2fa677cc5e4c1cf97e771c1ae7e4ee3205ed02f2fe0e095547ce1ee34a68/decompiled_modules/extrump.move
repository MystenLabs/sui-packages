module 0xd86a2fa677cc5e4c1cf97e771c1ae7e4ee3205ed02f2fe0e095547ce1ee34a68::extrump {
    struct EXTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXTRUMP>(arg0, 9, b"EXTRUMP", b"ElonTrump", b"Meme about Elon and Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e94656d-2296-4439-9499-23674faf4f0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x5b4fa4dea2b7ffc7ce02832d679108ddd77fbd5ee6dc46a823a91b74ebc6c68f::ws {
    struct WS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WS>(arg0, 9, b"WS", b"Waves", b"Wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10b09100-d2f6-4181-b441-50ee4567164f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WS>>(v1);
    }

    // decompiled from Move bytecode v6
}


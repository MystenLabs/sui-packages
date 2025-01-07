module 0x9d7ff1f2a6b51f360e5314af26101aaa8fc9902bfe4b00044c3cdc178978d563::sidra {
    struct SIDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIDRA>(arg0, 9, b"SIDRA", b"Chain", b"Sidra meme token. Buy sidra meme token.100% very good token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0b30c93-eb7b-4b58-b364-107b5e019e1f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIDRA>>(v1);
    }

    // decompiled from Move bytecode v6
}


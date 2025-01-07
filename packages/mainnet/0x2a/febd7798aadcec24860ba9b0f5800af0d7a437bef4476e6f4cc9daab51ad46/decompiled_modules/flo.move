module 0x2afebd7798aadcec24860ba9b0f5800af0d7a437bef4476e6f4cc9daab51ad46::flo {
    struct FLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLO>(arg0, 9, b"FLO", b"flowflow", b"Go with the flow with FlowiCoin: The fluid cryptocurrency that's seamlessly delivering smooth profits and effortlessly riding the waves of the crypto market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7de07a07-cfaa-4ebe-9275-bd58432cee0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x6ec92210b4fb458b59d45c7119c4896acc6e119068062356b7a49e8194506b32::aether_token {
    struct AETHER_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AETHER_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AETHER_TOKEN>(arg0, 9, b"ATH", b"Aether", b"Utility token of the InMotion Aether realm. Design / testnet only.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://inmotion.tech/aether-token.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AETHER_TOKEN>>(0x2::coin::mint<AETHER_TOKEN>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AETHER_TOKEN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AETHER_TOKEN>>(v2);
    }

    // decompiled from Move bytecode v7
}


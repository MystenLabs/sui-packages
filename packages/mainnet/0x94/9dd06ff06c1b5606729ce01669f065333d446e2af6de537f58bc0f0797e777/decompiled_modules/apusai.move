module 0x949dd06ff06c1b5606729ce01669f065333d446e2af6de537f58bc0f0797e777::apusai {
    struct APUSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APUSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<APUSAI>(arg0, 6, b"APUSAI", b"Apus Revolution by SuiAI", b"APUS represents a breakthrough in cognitive computing, leveraging advanced neural networks to create adaptive and responsive AI solutions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hbbi_f7f1b4f578.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APUSAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APUSAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


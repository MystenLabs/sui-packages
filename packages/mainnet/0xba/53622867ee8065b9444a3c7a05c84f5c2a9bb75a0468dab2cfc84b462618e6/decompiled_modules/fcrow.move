module 0xba53622867ee8065b9444a3c7a05c84f5c2a9bb75a0468dab2cfc84b462618e6::fcrow {
    struct FCROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCROW>(arg0, 6, b"FCROW", b"FROSTY CROW", b"Cold as ice and sharp as its beak. Frosty Crow is here to steal the spotlight.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_034712639_04d54b7d62.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCROW>>(v1);
    }

    // decompiled from Move bytecode v6
}


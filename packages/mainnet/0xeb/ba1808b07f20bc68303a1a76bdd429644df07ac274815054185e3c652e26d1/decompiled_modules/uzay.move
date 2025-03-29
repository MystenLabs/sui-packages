module 0xebba1808b07f20bc68303a1a76bdd429644df07ac274815054185e3c652e26d1::uzay {
    struct UZAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UZAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UZAY>(arg0, 9, b"Uzay", b"UzayLee", x"557a617920417261c59f74c4b1726d616c6172c4b1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7a2b799c3764387d6b6de2a7c606910ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UZAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UZAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


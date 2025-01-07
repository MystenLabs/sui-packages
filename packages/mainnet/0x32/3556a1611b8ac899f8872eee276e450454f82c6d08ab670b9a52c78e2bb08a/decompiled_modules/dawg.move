module 0x323556a1611b8ac899f8872eee276e450454f82c6d08ab670b9a52c78e2bb08a::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 6, b"DAWG", b"SUI DAWG", b"You only live once. Embrace that $DAWG in you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x8b42bf0fa7326deb111f03f31ba236adc6a5148d0c966a44f3f2a3dd8fbb3c75_dawg_dawg_5333016f09.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}


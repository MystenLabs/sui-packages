module 0x5b28db9b5ad59a122a20f3cc5531e337a523472503431501ce783dc843f570df::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLD>(arg0, 6, b"GOLD", b"GOLDIE", b"This is yours to enjoy, free from AI or animals, Just a coin driven by supply and demand. Unlike anything else in the market Join the movement and ride the wave to wealth!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736453802196.53")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


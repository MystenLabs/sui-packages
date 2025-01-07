module 0x45d2a472c4ec3c293d9e7d181b272b9d2cf5037b3fb453c2a2430743bf506909::suits {
    struct SUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITS>(arg0, 6, b"SUITS", b"Harvey Specter", x"0a546865206c6567656e6461727920486172766579205370656374657220617272697665732061742053756920746f20746561636820796f7520686f7720746f2073746f70206265696e67206120726f6f6b69652e204a6f696e2074686520245355495453207465616d2c20616e64206c6574e2809973206265636f6d65206d696c6c696f6e616972657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731018357671.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


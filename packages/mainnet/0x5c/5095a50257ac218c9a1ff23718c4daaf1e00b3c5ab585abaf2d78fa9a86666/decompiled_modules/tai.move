module 0x5c5095a50257ac218c9a1ff23718c4daaf1e00b3c5ab585abaf2d78fa9a86666::tai {
    struct TAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TAI>(arg0, 6, b"TAI", b"Trainer AI", b"Trainer AI comes from the deepest parts of the blockchain to capture all coins and learn all there is to know about our world and crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SUI_AI_Trainer_57c0ea370a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


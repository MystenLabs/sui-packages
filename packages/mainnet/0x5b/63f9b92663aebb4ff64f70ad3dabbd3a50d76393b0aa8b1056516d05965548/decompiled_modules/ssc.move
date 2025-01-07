module 0x5b63f9b92663aebb4ff64f70ad3dabbd3a50d76393b0aa8b1056516d05965548::ssc {
    struct SSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSC>(arg0, 6, b"SSC", b"Sad Sui Cat", b"The saddest cat in the world is now on sui! It's the symbol of sadness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asasasas_D_1_13f7ac9dd5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSC>>(v1);
    }

    // decompiled from Move bytecode v6
}


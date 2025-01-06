module 0x6db178318b7317d9e1c2e2256e9766451de6474c3059bd286dac04f5775260a::believe {
    struct BELIEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELIEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELIEVE>(arg0, 6, b"Believe", b"believe", x"7468652073756920776174657273206172652064656570206a7573742072656d656d62657220746f2062656c696576650a0a6120646563656e7472616c697a656420636f6d6d756e69747920636f696e2072656d696e64696e672075732074686174207761676d6920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2598_0d545f3142.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELIEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELIEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}


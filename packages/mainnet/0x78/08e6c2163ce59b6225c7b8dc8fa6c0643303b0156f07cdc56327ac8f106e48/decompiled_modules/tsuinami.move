module 0x7808e6c2163ce59b6225c7b8dc8fa6c0643303b0156f07cdc56327ac8f106e48::tsuinami {
    struct TSUINAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUINAMI>(arg0, 6, b"TSUINAMI", b"The Great Tsunami of Sui Ocean!", b"$TSUINAMI is the unstoppable force on Sui, bringing massive waves of energy and excitement. Get ready to surf the surge and make a splash on the great sui ocean with $TSUINAMI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TSUINAMI_67ed5ab166.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUINAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUINAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x44bc867c43803413a371816033f15ebbf63adc7930e6c6cabf6b6d7322a2b50d::chibsi {
    struct CHIBSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIBSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIBSI>(arg0, 6, b"CHIBSI", b"Sui Chibsi", b"chibsi a memecoin that has the power of nine tails", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008867_aea3901f7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIBSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIBSI>>(v1);
    }

    // decompiled from Move bytecode v6
}


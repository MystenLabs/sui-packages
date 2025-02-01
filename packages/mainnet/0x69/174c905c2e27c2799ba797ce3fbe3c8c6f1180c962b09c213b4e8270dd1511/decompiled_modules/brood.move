module 0x69174c905c2e27c2799ba797ce3fbe3c8c6f1180c962b09c213b4e8270dd1511::brood {
    struct BROOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROOD>(arg0, 6, b"BROOD", b"Brooder", x"42726f6f64657220697320616e0a414920656e67696e6520666f7220610a6e65772067656e65726174696f6e0a6f662063726561746f72732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087939_1eadf7f2ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROOD>>(v1);
    }

    // decompiled from Move bytecode v6
}


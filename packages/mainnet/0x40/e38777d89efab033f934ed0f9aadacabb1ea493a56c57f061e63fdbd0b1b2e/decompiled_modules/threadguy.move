module 0x40e38777d89efab033f934ed0f9aadacabb1ea493a56c57f061e63fdbd0b1b2e::threadguy {
    struct THREADGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: THREADGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THREADGUY>(arg0, 6, b"THREADGUY", b"peter todd vs hbo", x"706574657220746f64643a206920616d206e6f74207361746f7368690a0a48424f3a20706574657220746f6464206973207361746f736869200a0a706574657220746f64643a2069207361696420696d206e6f74207361746f736869200a0a48424f3a20706574657220746f6464206973207361746f736869200a0a706574657220746f64643a2049205341494420494d204e4f54205341544f5349200a0a48424f3a2053485554205550207765206265742054454e204d494c4c494f4e206f6e20706f6c796d61726b6574207468617420796f757265207361746f73686920594f5520415245205341544f534849200a0a6f757220696e6475737472792069732061206a6f6b6520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4447_de24e65a39.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THREADGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THREADGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}


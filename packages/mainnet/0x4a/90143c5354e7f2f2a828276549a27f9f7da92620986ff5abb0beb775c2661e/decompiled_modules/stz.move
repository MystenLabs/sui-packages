module 0x4a90143c5354e7f2f2a828276549a27f9f7da92620986ff5abb0beb775c2661e::stz {
    struct STZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: STZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STZ>(arg0, 6, b"Stz", b"Sui Tzu", x"2054696d696e6720616e64207072657061726174696f6e2061726520657373656e7469616c20746f20737563636573732e2057652061726520636f6d6d69747465642067726f77696e6720746f676574686572207769746820737569206e6574776f726b206c696b652074686520417274206f66207761722e2053756920547a750a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087588_877814fb92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STZ>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xdb496f8073caea9cc89eae5fb81a1cc9412f3f63bf93b12039a60243584ad78a::poseidon {
    struct POSEIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSEIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSEIDON>(arg0, 6, b"POSEIDON", b"Sui Posedion", x"506f736569646f6e206973206865726520746f20636c61696d2068697320726967687466756c207468726f6e652061732074686520476f64206f6620746865205375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Poseidon_1_c666d3ffa7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSEIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSEIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}


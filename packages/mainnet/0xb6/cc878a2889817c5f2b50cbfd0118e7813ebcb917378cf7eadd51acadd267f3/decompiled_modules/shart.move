module 0xb6cc878a2889817c5f2b50cbfd0118e7813ebcb917378cf7eadd51acadd267f3::shart {
    struct SHART has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHART>(arg0, 6, b"Shart", b"Shartcoin", x"46617274636f696e206275742077657474657220746865207065726665637420446567656e20636f696e20666f722074686520776174657220636861696e0a0a54686520776574746573742066617274206f6e20737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2784_12b76c6a90.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHART>>(v1);
    }

    // decompiled from Move bytecode v6
}


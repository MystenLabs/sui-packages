module 0x257b70b9fdf3f5d047a1e8a05e61d15869942a1cc846f7ed9e6f32feaf814454::sushi {
    struct SUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSHI>(arg0, 6, b"SUSHI", b"SushiTheDog", x"53757368692054686520446f67206f6e2054696b20546f6b2e20322e374d2b20666f6c6c6f776572732e200a53757368692048617320466f756e642048657220486f6d65204f6e205375692e0a506963747572652046726f6d205468652053757368692049472040737573686973616964", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sushitehdog_6f396c09bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}


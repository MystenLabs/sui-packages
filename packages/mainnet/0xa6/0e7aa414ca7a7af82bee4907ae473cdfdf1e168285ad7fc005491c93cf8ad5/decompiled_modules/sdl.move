module 0xa60e7aa414ca7a7af82bee4907ae473cdfdf1e168285ad7fc005491c93cf8ad5::sdl {
    struct SDL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDL>(arg0, 6, b"SDL", b"Sui Dolphin Legend", b"We're going to be legends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_21_49_27_d65c9d1a03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDL>>(v1);
    }

    // decompiled from Move bytecode v6
}


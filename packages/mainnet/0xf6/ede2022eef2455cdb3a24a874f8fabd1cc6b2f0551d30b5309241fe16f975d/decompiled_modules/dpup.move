module 0xf6ede2022eef2455cdb3a24a874f8fabd1cc6b2f0551d30b5309241fe16f975d::dpup {
    struct DPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPUP>(arg0, 6, b"DPUP", b"D.O.G Puppies", b" puppies is a dog, puppies is a best friend, puppies is a love, puppies is a community and puppies is a meme world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726901387499_f7abce3428aa6b4186ccd141ea388b6e_c609e1f779.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xd4cc8078c1fdf26177de0fe5432e123b9944af31767dfff31a66fc33f49fd3f9::ppy {
    struct PPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPY>(arg0, 6, b"PPY", b"PAPAY", b"First PAPAY Coin . it will Just Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_dd90ca098a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


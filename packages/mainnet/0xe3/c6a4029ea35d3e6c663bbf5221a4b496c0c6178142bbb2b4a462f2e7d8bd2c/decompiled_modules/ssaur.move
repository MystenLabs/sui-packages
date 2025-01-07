module 0xe3c6a4029ea35d3e6c663bbf5221a4b496c0c6178142bbb2b4a462f2e7d8bd2c::ssaur {
    struct SSAUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSAUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSAUR>(arg0, 6, b"SSAUR", b"Suilsaur", b"Roarrrrrrr I'm gonna be the leader of the Sui memes! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_17_at_10_06_38_AM_5a09d320e8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSAUR>>(v1);
    }

    // decompiled from Move bytecode v6
}


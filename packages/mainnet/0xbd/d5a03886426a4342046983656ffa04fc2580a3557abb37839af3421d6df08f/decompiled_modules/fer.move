module 0xbdd5a03886426a4342046983656ffa04fc2580a3557abb37839af3421d6df08f::fer {
    struct FER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FER>(arg0, 6, b"FER", b"FERRET", b"AWDAWDASDSXDAWDASDAWDAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_23_d9ea7ac042.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FER>>(v1);
    }

    // decompiled from Move bytecode v6
}


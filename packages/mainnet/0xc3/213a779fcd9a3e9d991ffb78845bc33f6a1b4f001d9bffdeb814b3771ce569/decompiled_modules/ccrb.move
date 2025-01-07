module 0xc3213a779fcd9a3e9d991ffb78845bc33f6a1b4f001d9bffdeb814b3771ce569::ccrb {
    struct CCRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCRB>(arg0, 6, b"CCRB", b"CHEERY CRAB", x"0a50696e6368696e67206d656d657320616e64206a6f792c2043686565727920437261622073637574746c657320737472616967687420696e746f20796f757220706f7274666f6c696f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_025305650_3ae154515e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCRB>>(v1);
    }

    // decompiled from Move bytecode v6
}


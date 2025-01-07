module 0x59aea542fc32d4962721a968302fb724cee8effb271cde33af5d66a01bf18edd::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 6, b"SS", b"SUI SPEAK", b"BETA LANGUAGE APP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_1_05e825acc4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SS>>(v1);
    }

    // decompiled from Move bytecode v6
}


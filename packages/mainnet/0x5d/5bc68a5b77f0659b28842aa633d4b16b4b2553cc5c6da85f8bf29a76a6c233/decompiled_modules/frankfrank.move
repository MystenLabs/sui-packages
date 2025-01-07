module 0x5d5bc68a5b77f0659b28842aa633d4b16b4b2553cc5c6da85f8bf29a76a6c233::frankfrank {
    struct FRANKFRANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRANKFRANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRANKFRANK>(arg0, 6, b"FRANKFRANK", b"frankfrankfrank", b"franktrushfrankmoneyfrankking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/frank_laser_0dee82e7ec.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRANKFRANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRANKFRANK>>(v1);
    }

    // decompiled from Move bytecode v6
}


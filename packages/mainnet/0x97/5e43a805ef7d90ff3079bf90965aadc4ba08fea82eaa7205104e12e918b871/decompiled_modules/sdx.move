module 0x975e43a805ef7d90ff3079bf90965aadc4ba08fea82eaa7205104e12e918b871::sdx {
    struct SDX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDX>(arg0, 6, b"SDX", b"SuiDex", x"537569446578202d204d616b65206974206561737920746f20737761700a77696c6c20617661696c61626c65206f6e2061707073746f726520616e6420706c617973746f7265206f63742c2031352032303234", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241006_132842_0000_be4e332585.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDX>>(v1);
    }

    // decompiled from Move bytecode v6
}


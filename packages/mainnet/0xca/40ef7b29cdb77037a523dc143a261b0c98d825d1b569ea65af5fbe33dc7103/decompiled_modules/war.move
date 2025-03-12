module 0xca40ef7b29cdb77037a523dc143a261b0c98d825d1b569ea65af5fbe33dc7103::war {
    struct WAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAR>(arg0, 6, b"WAR", b"Sonic The Trench Hog", b"with fast punch and run speed, sonic is ready to fight, war", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000071944_fb888c6136.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAR>>(v1);
    }

    // decompiled from Move bytecode v6
}


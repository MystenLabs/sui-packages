module 0x712a4fc9429402c4b9e5d1b8a097421d0a581000f41b99a53a988ef608af39c::suigod {
    struct SUIGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOD>(arg0, 6, b"SUIGOD", b"SUI GOD NIKA", b"The Legend of Sun God Nika Sui: The Dawn of the Next Meme Meta on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038892_fe8a65e44c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}


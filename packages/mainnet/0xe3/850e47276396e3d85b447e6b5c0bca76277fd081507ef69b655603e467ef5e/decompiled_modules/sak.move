module 0xe3850e47276396e3d85b447e6b5c0bca76277fd081507ef69b655603e467ef5e::sak {
    struct SAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAK>(arg0, 6, b"SAK", b"S N A K E I N C A N", b"game snake on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snakefull_b1da610b6f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAK>>(v1);
    }

    // decompiled from Move bytecode v6
}


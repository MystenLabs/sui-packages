module 0x9053e619ff548d999895108cd0a4900acf8406ac9bcec490d3c9b4c653888b4e::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVATAR>(arg0, 9, b"AVATAR", b"AVATAR", b"AVATAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/dN5w5Qx.jpeg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVATAR>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AVATAR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVATAR>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}


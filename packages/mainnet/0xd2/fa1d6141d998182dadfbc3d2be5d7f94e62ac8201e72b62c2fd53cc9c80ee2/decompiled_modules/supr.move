module 0xd2fa1d6141d998182dadfbc3d2be5d7f94e62ac8201e72b62c2fd53cc9c80ee2::supr {
    struct SUPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPR>(arg0, 9, b"SUPR", b"Suipernova", b"Suipernova is the newest, hottest meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1786393265614315520/sAYizQkX.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUPR>(&mut v2, 330000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPR>>(v1);
    }

    // decompiled from Move bytecode v6
}


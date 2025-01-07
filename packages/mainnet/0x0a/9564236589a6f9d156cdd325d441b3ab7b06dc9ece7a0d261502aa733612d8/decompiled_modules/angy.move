module 0xa9564236589a6f9d156cdd325d441b3ab7b06dc9ece7a0d261502aa733612d8::angy {
    struct ANGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGY>(arg0, 9, b"ANGY", b"Angela", b"Angela is about to become most viral meme on the hottest blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1217945642472894465/ztaKVdzF.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANGY>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x31dc5ee2cf93447d4821648a0571cb794cfb1d0c43302b010c2376975b3a2d95::meta {
    struct META has drop {
        dummy_field: bool,
    }

    fun init(arg0: META, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<META>(arg0, 9, b"META", b"META", b"FACEBOOK META Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<META>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<META>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<META>>(v1);
    }

    // decompiled from Move bytecode v6
}


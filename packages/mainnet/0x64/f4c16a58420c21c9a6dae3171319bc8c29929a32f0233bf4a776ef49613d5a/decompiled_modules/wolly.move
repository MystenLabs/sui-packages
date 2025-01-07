module 0x64f4c16a58420c21c9a6dae3171319bc8c29929a32f0233bf4a776ef49613d5a::wolly {
    struct WOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLLY>(arg0, 9, b"WOLLY", b"WOLLY", b"Sweet and cute WOLLY meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1786393265614315520/sAYizQkX.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOLLY>(&mut v2, 1800000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}


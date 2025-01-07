module 0x5f675d38927089710309ca16322f2045b0ff5627e1273d6c566d707e7aa7db42::aaak {
    struct AAAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAK>(arg0, 9, b"AAAK", b"Aaaaa Kitten", b"Telegram : https://t.me/aaakitten, Web : https://aaakitten.fun/ , X : https://twitter.com/aaakitten", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1842270576699957248/JYthUwHo.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAAK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAK>>(v1);
    }

    // decompiled from Move bytecode v6
}


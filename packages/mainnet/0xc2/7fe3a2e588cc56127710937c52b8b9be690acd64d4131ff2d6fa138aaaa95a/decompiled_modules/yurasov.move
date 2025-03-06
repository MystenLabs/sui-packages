module 0xc27fe3a2e588cc56127710937c52b8b9be690acd64d4131ff2d6fa138aaaa95a::yurasov {
    struct YURASOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: YURASOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YURASOV>(arg0, 9, b"YURASOV", b"Yura Borisov", b"Born: December 8, 1992, Reutov, Russia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/YURASOV.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YURASOV>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YURASOV>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YURASOV>>(v1);
    }

    // decompiled from Move bytecode v6
}


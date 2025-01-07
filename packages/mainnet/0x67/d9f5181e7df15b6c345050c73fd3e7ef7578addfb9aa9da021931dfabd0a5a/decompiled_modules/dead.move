module 0x67d9f5181e7df15b6c345050c73fd3e7ef7578addfb9aa9da021931dfabd0a5a::dead {
    struct DEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAD>(arg0, 5, b"DEAD", b"Dead Coin", b"The End is Near!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/CgQoqef.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<DEAD>(&mut v2, 2000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEAD>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x9f504ff50830fdcad379de33d17b5a47cd114ef7720a6b6bad88bf29589f404c::suig {
    struct SUIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIG>(arg0, 6, b"SUIG", b"SUIGAS", b"Sui Gas is an old project of ours and we worked very hard to build it this far by our blood and swat but we came to realize that why don't we launch our own coin,by that it'll also make a name of ours in crypto industry so we can do our work effeciently and so we can give more relief in bills of people in need.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000126520_2fdd45d1c0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIG>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xdaf7a7a66a5c94f0ccc4c1979b4a635c4743678cf25b6c567c7d4e67da8d2ab::suig {
    struct SUIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIG>(arg0, 6, b"SUIG", b"SUIGAS", b"Sui Gas is an old project of ours and we worked very hard to build it this far by our blood and swat but we came to realize that why don't we launch our own coin,by that it'll also make a name of ours in crypto industry so we can do our work effeciently and give people more relief in their bills.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000126520_37ec6f63c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIG>>(v1);
    }

    // decompiled from Move bytecode v6
}


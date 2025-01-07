module 0xcdf74460300085275516c5c076b84d9991396b3130066ee29d3ac8471b34dc4f::panther {
    struct PANTHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANTHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANTHER>(arg0, 6, b"PANTHER", b"Pink Panther", b"Want to stay ahead in crypto?  Join Degenaires for exclusive updates on the hottest projects, airdrops, NFTs, and more! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1724881211937_96573af64a6cd8cf469d56dac4ee03e6_16ce958956.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANTHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANTHER>>(v1);
    }

    // decompiled from Move bytecode v6
}


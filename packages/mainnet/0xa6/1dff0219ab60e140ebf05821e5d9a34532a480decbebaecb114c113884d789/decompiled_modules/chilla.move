module 0xa61dff0219ab60e140ebf05821e5d9a34532a480decbebaecb114c113884d789::chilla {
    struct CHILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLA>(arg0, 9, b"CHILLA", b"CHILLA SUI", b"Your coat makes me endangered, my memes makes you rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPcoTM6kUiT9esFoVjCT78z1GjnwWuFkyWvTYsZfGEKqt")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHILLA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xb6396c76c36487dea544e86519b491ca6e914789cc3a36114cda54d3b3b3c814::chop6900 {
    struct CHOP6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOP6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOP6900>(arg0, 6, b"CHOP6900", b"CHOP 6900", b"Attention Attention Attention!! FOR SALE: CHOP6900 coin launching with the most expensive NFT on Sui. Once mint gates swing open, every memer, degen, and SUI HODLer will feast on this one-of-one, diamond-level JPG. Trust me, you can't afford it. We're not just aiming for the Moon, we're rocketing straight to Mars, complete with exclusive Ramen Hall of Fame shout-outs for our chop-ride-or-die crew. Eat more CHOP6900, drink more SUI. Be on-chain or be square", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiapv3onqet2qmp5p237hvfs2rsrq26fwsqc3666kgpekf3jytaxgq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOP6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHOP6900>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


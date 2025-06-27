module 0xd9434dfe958bc48603a381c1b4a4ea7886664f677270af89f41fdbd5ac14825f::ket {
    struct KET has drop {
        dummy_field: bool,
    }

    fun init(arg0: KET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KET>(arg0, 6, b"KET", b"MewKet", b"Orbs are mystical objects in the world of Ket. They serve as a form of currency used by locals for transactions. Some believe these orbs hold the potential for grand purposes, but their true origin remains unknown.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigh4eyead6ltudxyh76cniehv5p4f5ycskevutjnzxmq7iutmpzrq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


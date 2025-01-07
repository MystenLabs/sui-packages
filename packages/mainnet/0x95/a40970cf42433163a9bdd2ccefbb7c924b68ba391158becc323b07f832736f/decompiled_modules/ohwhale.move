module 0x95a40970cf42433163a9bdd2ccefbb7c924b68ba391158becc323b07f832736f::ohwhale {
    struct OHWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OHWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OHWHALE>(arg0, 6, b"OhWhale", b"Whale", b"Whale is the mascot of Sui; there is no better mascot than a whale. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Image_9_24_24_at_9_44a_PM_639821b717.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OHWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OHWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}


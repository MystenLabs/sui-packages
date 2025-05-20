module 0x15b669b9c26790377992fea3923740441534973497eeda19095d117cf61bdde0::sellonsui {
    struct SELLONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELLONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELLONSUI>(arg0, 6, b"SellOnSui", b"Seel", b"Seel is the cutest seal on sui, Born from a passion for both cute marine creatures and blockchain technology, SEEL emerged as the undisputed cutest seal-themed token in the SUI ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihgg4ktgdu62qatrdnrjccnoku4poor4e54affas2tkuactpggxnq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELLONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SELLONSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


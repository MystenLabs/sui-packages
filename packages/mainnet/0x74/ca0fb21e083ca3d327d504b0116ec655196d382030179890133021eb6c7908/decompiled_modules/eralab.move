module 0x74ca0fb21e083ca3d327d504b0116ec655196d382030179890133021eb6c7908::eralab {
    struct ERALAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERALAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERALAB>(arg0, 9, b"EraLab", b"EraLabs", b"EraLabs fuses AI with Solana's speed, delivering cutting-edge tools like EraChat, EraMixer, and EraSearch for an unparalleled crypto experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcchmQks1baoHk9sBp6uKYLFsURqSvm5CajNBtefDB4QU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ERALAB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERALAB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERALAB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x9d7546b9faba8bdf1e8315b36074e902b0c083339c8917255cf2b744e6042506::evf {
    struct EVF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVF>(arg0, 6, b"EVF", b"Evofrog", b"EvoFrog Inspired by the epic evolution of Froakie to Greninja", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifaqyz7cv2riwui75gohewyxgjspgpog4p2jfszu6f7eyxyt5c5zu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


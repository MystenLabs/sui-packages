module 0xe51066bd0006a308be76277b9958e3375a1fe6f0078d831bc9b18150a417702c::tosa {
    struct TOSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSA>(arg0, 6, b"TOSA", b"TOSA SUI", b"Meet $TOSA, the first-ever dog memecoin born on the Sui blockchain via MOONBAG  where memes meet speed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif7waxnr2j5rznbkdhoo3aeapmdoztdiyar6dhohztexcrlbvelue")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOSA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x37614e13afe537974370e669be03235530b1765764365959ed9c2a85a85d2cff::sammy {
    struct SAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMMY>(arg0, 9, b"Sammy", b"Success Kid", b"Success Kid\" meme's spirit of determination, transforming the iconic clenched fist into a symbol of relentless pursuit for success in the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmckLPm9wV7haktuCebQ2wi2D66xus38vZ9CFNSxhntQf7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAMMY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAMMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMMY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


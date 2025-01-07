module 0x29e75301791bee19ca29480984d1cae9bd9d49bd961cc0e76d7466485393adf::cs {
    struct CS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CS>(arg0, 6, b"CS", b"CHILLSMOKE", b"Elevate your crypto journey with $CHILLSMOKE. Join a vibrant community, chill out, and unlock the potential of the future. Every puff brings you closer to financial freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733862707190.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


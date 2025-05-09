module 0x7fa9740b4b10570d368fef5a7e4049bdad67e40eec7cb892d89ffae7b5294683::dolph {
    struct DOLPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPH>(arg0, 6, b"DOLPH", b"DOLPH SUI", b"$DOLPH Making Waves on Sui Swim with the Fun, Surf the Gains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigglsye27kxljq74x5dazn6dyglo2gcs2ha6dv4odmufe5ophx75a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOLPH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


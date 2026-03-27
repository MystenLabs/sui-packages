module 0x948623376c9ddb6a2ee1aefbe60bceb6d61caf3500e110efa4862530bb64eb98::suiminion {
    struct SUIMINION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMINION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMINION>(arg0, 6, b"SUIMINION", b"Suiminion Sui", b"The Suiminion is Born  A symbol of HOPE for all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiayrbjoaujj2cyie7cjlfyeig6xvw4wlzfr4moeyslsw4knpn665i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMINION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMINION>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


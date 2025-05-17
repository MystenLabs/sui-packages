module 0x68db318d64c90b9fe8048af5a74463b8f4a3137d7a24e2a7227a542ffb1a6e2e::savior {
    struct SAVIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVIOR>(arg0, 6, b"SAVIOR", b"Savior one", b"an Art Nouveau-inspired depiction of Elphaba and The Wonderful Wizard of Oz in a glowing throne room", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidlrig4mbgu2d7k4ilgl7zunowrzvyhpsegevlog6uev4ab4pg6pe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVIOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAVIOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


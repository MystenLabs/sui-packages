module 0x88d097737ff95e436a273cc49c5e5c72acfb6cd3cd30c2362f3bdc47bece92a1::toot {
    struct TOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOOT>(arg0, 6, b"TOOT", b"Tootcoin on Sui", b"$TOOT is riding the widns of $FART's explosive success. Get ready to toot your way to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicmqnnk4dplydazdzqdltwnb4yztj7fqzce4idgvgigby7dst4yai")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOOT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


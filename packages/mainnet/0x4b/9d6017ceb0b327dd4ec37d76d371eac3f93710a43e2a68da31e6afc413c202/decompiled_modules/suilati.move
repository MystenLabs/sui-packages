module 0x4b9d6017ceb0b327dd4ec37d76d371eac3f93710a43e2a68da31e6afc413c202::suilati {
    struct SUILATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILATI>(arg0, 6, b"SUILATI", b"Suilati Pokemon", b"$SUILATI token draws inspiration from Latios and Latias, symbolizing unity and harmony with their heart-shaped bond. It fosters a community of creativity and adventure. Join the journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihmjc7gjbqmcuw7qa3hxs6q3e73fpy5refbbverg7badyfgvaqzay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILATI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


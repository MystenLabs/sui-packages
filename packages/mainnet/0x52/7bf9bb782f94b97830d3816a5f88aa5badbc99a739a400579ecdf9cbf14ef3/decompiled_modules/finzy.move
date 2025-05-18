module 0x527bf9bb782f94b97830d3816a5f88aa5badbc99a739a400579ecdf9cbf14ef3::finzy {
    struct FINZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINZY>(arg0, 6, b"Finzy", b"Finzy Sui", b"Finzy the graffiti artist street fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihndeqwmdxgavndcaegpwzga4rqqp7cmhvonoziliy3obnlddxr6m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FINZY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


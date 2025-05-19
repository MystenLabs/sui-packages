module 0x435a64fa8637e69bf2bd1cd76015e32fd33f915ab8233772e576c82f8b53cd08::bunee {
    struct BUNEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNEE>(arg0, 6, b"BUNEE", b"Bunee on Sui", b"Bunee is a chill bunny, Art based project bringing art to the Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreife7wgsjyw5cmrvmlorlyzjae75jv2mosmgpgwxwf5jidzhx4mfii")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUNEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


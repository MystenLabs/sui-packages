module 0x8cac6a54080046efc41ae235b37e664c9ceb4dbe7e76a55a27ee9b32fa8cb97a::doget {
    struct DOGET has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGET>(arg0, 6, b"DOGET", b"DOGE", b"DOGE ticker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib54zte7wqazcayjndmsbvg4k6y3zdjxm6mckjnqvftnfjhuqpdie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


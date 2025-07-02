module 0x66c60ab44277d913fff3478d86871b90f20b1336214cd34e67f7a4e422e66119::snipers {
    struct SNIPERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIPERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIPERS>(arg0, 6, b"Snipers", b"Snip", b"Dont buy this shit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihwhnbaym5ethmz7k4thjr7q7dblss2hmcesma5b3kb74cq6bowg4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIPERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNIPERS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


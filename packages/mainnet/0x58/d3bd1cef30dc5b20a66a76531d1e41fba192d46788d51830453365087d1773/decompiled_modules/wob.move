module 0x58d3bd1cef30dc5b20a66a76531d1e41fba192d46788d51830453365087d1773::wob {
    struct WOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOB>(arg0, 6, b"WOB", b"Pokewob", b"The blue king of bouncebacks is almost here. calm, cool, and about to shake up the meme coin game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5qvsog2wzqsxyaskqh4tflbj63yuziwcbi73bfmibz66h6e4tt4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


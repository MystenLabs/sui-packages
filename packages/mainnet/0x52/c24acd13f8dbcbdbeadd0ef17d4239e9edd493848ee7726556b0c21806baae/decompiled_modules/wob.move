module 0x52c24acd13f8dbcbdbeadd0ef17d4239e9edd493848ee7726556b0c21806baae::wob {
    struct WOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOB>(arg0, 6, b"Wob", b"Pokewob", b"Join the wobble. Reflect the chaos. Counter to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5qvsog2wzqsxyaskqh4tflbj63yuziwcbi73bfmibz66h6e4tt4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


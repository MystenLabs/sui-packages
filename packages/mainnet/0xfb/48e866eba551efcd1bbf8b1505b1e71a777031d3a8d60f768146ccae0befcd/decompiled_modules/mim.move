module 0xfb48e866eba551efcd1bbf8b1505b1e71a777031d3a8d60f768146ccae0befcd::mim {
    struct MIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIM>(arg0, 6, b"MIM", b"MAGIC INTERNET MONEY", b"MIM MAKE THE MILLION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib2ksun25wl6xn6cdqz5mlyefaotqsvvzk6b4jczcoxsxm3chjxue")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


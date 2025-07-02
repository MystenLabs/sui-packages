module 0xa95691506a1921f7bcad6e0f97919253f12ba150de1c9951832913a5ad029abb::kaws {
    struct KAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAWS>(arg0, 6, b"KAWS", b"Kaws Tokeb", b"The first Kaws token in crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih5yhebdkqkpcd2husn6enxy5l4eet5jjvv6tso3sxha272b5c66e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAWS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x2c4c7cc8e3b22a5e580421394c6753a89d8f73ff9609f54099a401d2694d8b28::sweety {
    struct SWEETY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWEETY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEETY>(arg0, 6, b"SWEETY", b"SWEETY on SUI", b"Sweetest thing on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihrzeuqjovrteyiupjrduy74w7tab6w6psdma7xtsyeyvuangcqii")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEETY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWEETY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


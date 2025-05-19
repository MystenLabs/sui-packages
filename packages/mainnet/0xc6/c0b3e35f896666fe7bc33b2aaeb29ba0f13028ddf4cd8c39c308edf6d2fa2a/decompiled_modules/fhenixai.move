module 0xc6c0b3e35f896666fe7bc33b2aaeb29ba0f13028ddf4cd8c39c308edf6d2fa2a::fhenixai {
    struct FHENIXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHENIXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHENIXAI>(arg0, 6, b"FhenixAI", b"Fhenix AI", b"Enkripsi FHE di Sui Move Smart Contracts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih53crj4svbwkj5gsduufbsy5h5gpcbnvzbbghmwcfahspedkjh4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHENIXAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FHENIXAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


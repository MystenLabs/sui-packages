module 0x7405059a8ce8119f1b864210027ba379065db3b320fc28e640027b6b6f47ada1::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 9, b"NEIRO", b"Neiro on SUI", b"Neuro Official Community on Solana.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbpGkMoiyjsBq1yPGxLjGqEdw6DdmzuwXg8WGzy2pH7op")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEIRO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


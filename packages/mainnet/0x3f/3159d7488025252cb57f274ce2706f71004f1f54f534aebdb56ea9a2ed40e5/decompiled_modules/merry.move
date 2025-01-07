module 0x3f3159d7488025252cb57f274ce2706f71004f1f54f534aebdb56ea9a2ed40e5::merry {
    struct MERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERRY>(arg0, 9, b"MERRY", b"Merry Paws", b"Merry Paws is here to play Santa and bring joy to your wallets this season.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeia54ykctodfki4ef353udcg3po3g6dsvai3mruusmfzdowk4azwvy.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MERRY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MERRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERRY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xcbcf8b001b5328a20fd422f4bf2a29374f98529ffa50a6a12d346b9e5dc6ba8b::guud {
    struct GUUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUUD>(arg0, 6, b"GUUD", b"GuudTheGoat", b"Guud is the goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicxkpp2du2roro55crq3cfsmqozweoaoyrqy42oh3hpeiv3tj6j4m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUUD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


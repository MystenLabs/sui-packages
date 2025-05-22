module 0xd8fc80db55a70e4168441d0196465046f3488f13ebe50e5250dafa175f8ea8a5::terry {
    struct TERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERRY>(arg0, 6, b"Terry", b"Terry the GOAT", b"TERRY IS A FRENCH BOURGEOISIE GOAT WHO LAUNCHED HIMSELF TO MOON SUI. Terry the Goat is an ambitious meme project, looking to build a kingdom on SUI with the help of our community. With a goal of making you laugh, at the heart, we also want to grow together so that we can all be bourgeoisies thanks to the G.O.A.T.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreier64u5fm4satjsawkdftkb6rrenqo5q6xnqh7tyufgwwftozwo2m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TERRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


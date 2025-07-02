module 0xfabd45a64de0002eaa5fa52532eb9066a3309e3e06b95b6bc50c9549d03f8359::here {
    struct HERE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERE>(arg0, 6, b"Here", b"We still here", b"No one can stop us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidcmdw7e2vxp7oafoouvma4yeihadmnaqefmnweqmztzgfkiwyslm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HERE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


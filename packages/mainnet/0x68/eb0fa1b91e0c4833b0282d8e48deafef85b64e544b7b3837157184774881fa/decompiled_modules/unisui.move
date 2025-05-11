module 0x68eb0fa1b91e0c4833b0282d8e48deafef85b64e544b7b3837157184774881fa::unisui {
    struct UNISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNISUI>(arg0, 6, b"UNISUI", b"Uni Sui", b"UNISUI is a memecoin project built on the Sui network, combining community power with modern blockchain technology. More than just a meme, UNI SUI represents participation, transparency, and fun adoption in the Web3 world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeid4uvybntv4n6zqvb76g7m27wdq6iuwmkszlle7zajuswwd2wkcg4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UNISUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


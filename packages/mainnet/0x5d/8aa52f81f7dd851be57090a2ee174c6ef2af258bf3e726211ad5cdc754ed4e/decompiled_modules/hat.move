module 0x5d8aa52f81f7dd851be57090a2ee174c6ef2af258bf3e726211ad5cdc754ed4e::hat {
    struct HAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAT>(arg0, 6, b"HAT", b"Hat On Sui", b"HAT is unique, apart from the design inspired by a great Sui,  $HAT also has a community that is built naturally", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie2zm4vw3sgejvn4dfd4rqtmdxd4mvfdgeqbsoicc6mkyte2egj4m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


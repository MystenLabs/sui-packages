module 0x23ade4e2ef9027cabd609d8b50173174baa5e3f10c79b8e7d9c85e3288e3a438::trapp {
    struct TRAPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAPP>(arg0, 6, b"TRAPP", b"TRAPP THE HIPPO", b"The original Trapp project back on Moonbags.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicf6haanubh47t6lg6hy7iz34u5mu6oyx62jjfdobuvfqtar5recq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRAPP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


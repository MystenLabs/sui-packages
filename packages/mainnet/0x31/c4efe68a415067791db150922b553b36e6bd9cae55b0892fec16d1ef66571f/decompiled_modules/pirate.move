module 0x31c4efe68a415067791db150922b553b36e6bd9cae55b0892fec16d1ef66571f::pirate {
    struct PIRATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRATE>(arg0, 6, b"PIRATE", b"Pirate Dog", b"Now is dog seaason are you ready to sail", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidlqjeebzhbfe2ep4w2t52ajeux667k3tw3b7zo3f5f7eby24zmxe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIRATE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


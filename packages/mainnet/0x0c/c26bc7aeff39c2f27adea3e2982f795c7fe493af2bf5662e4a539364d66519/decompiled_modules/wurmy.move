module 0xcc26bc7aeff39c2f27adea3e2982f795c7fe493af2bf5662e4a539364d66519::wurmy {
    struct WURMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WURMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WURMY>(arg0, 6, b"WURMY", b"Wurmy Wolf", b"The wildest meme token on Sui. Powered by wolves, driven by community. WURMY Wolf is here to howl.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibvlhpgsawh3hbbqh3yqgk7q6shtrmqcusuncq7llpgrghilqwhkm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WURMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WURMY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


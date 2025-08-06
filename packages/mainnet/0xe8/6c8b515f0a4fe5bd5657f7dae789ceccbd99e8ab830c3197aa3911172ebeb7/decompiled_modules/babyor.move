module 0xe86c8b515f0a4fe5bd5657f7dae789ceccbd99e8ab830c3197aa3911172ebeb7::babyor {
    struct BABYOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYOR>(arg0, 6, b"BABYOR", b"Baby Gorbagana", b"\"Rock-a-bye baby, on Sui so high, when the market pumps, your portfolio will fly!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiavlifef7jcl43vhggb3ctdrrjxi5txm4ojaum6g3q263hd44bevy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


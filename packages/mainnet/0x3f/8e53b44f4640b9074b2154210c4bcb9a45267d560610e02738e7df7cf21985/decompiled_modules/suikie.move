module 0x3f8e53b44f4640b9074b2154210c4bcb9a45267d560610e02738e7df7cf21985::suikie {
    struct SUIKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKIE>(arg0, 6, b"SUIKIE", b"SUIKIECHAN", b"Suikiechan is a kung fu master from the neon-soaked streets of crypto China Town. With a sharp fist and sharper instinct for memecoins, he moves from dojo to DEX, kicking FUD and throwing fiat like a true degen monk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihqdneekgk7gpliw3omfwn7oyi6sabs6c7ba2obj2dxlzj2asdq3q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIKIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


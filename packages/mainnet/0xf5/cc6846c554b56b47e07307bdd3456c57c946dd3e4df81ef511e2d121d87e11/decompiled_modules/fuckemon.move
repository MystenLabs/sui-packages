module 0xf5cc6846c554b56b47e07307bdd3456c57c946dd3e4df81ef511e2d121d87e11::fuckemon {
    struct FUCKEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKEMON>(arg0, 6, b"FUCKEMON", b"FUCK POKEMON", x"4655434b205448495320504f4b454d4f4e204d4554410a0a4252494e47204241434b205245414c204d454d4553", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiedw2zxvetv7u66t6fxd4vodsbojydzy2yrx3dkfx7vqn6kp5eame")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUCKEMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


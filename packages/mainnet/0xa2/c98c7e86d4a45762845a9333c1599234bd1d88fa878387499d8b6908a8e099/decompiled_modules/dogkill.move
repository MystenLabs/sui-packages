module 0xa2c98c7e86d4a45762845a9333c1599234bd1d88fa878387499d8b6908a8e099::dogkill {
    struct DOGKILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGKILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGKILL>(arg0, 6, b"DOGKILL", b"DOG KILLER", b"Killer doggi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiewu3ipy3ka3e6t6oxa5ds6emadxmc5mjx3zu7z22fcs5kvpecdce")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGKILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGKILL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x70702e88ac1b461c14e46d601c69d855289dc073c7a272bd6f7c3aede3cdb93b::suiandy {
    struct SUIANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIANDY>(arg0, 9, b"SuiAndy", b"Sui Andy", b"Andy, Pepe's mischievous friend and roommate has come to Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c5359eef33e847d6e3cad16d0677a070blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIANDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIANDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


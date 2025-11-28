module 0xcc47bbc70ac019aa54762b21d187f9d3ff73a5bc41543b29187b5dd0a52ac391::morph {
    struct MORPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORPH>(arg0, 6, b"MORPH", b"SuiMorph", b"SuiMorph is a secret - we will reveal our identity one day - don't wait for others to buy $MORPH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibyqxon6i6ijnhekokbol65ytnu5lakf4lzgdmwtoreycetnq3l7e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MORPH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xb4c909d2fb0156844cf96d8ce890ce4433e2009cfc5046682a111eb106452646::zeus {
    struct ZEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEUS>(arg0, 6, b"Zeus", b"SuiZeus", b"$ZEUS is based on Pepe the Dog, a character from Matt Furies Boys Club comics. Hes a lesser-known figure in Pepe lore, depicted as a silent protector and the swamps secret guardian, watching from the shadows while other characters like frogs and cheems take the spotlight. Now, hes emerging from the background onto the blockchain. This isnt just another memecoin; its a revival, a narrative-driven project, and a nod to the origins of meme culture, grounded in its roots.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidzlrb6cf77lkiftjngdev2xemmo3ntvswwxl37h4pjfqjjnnjcee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZEUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


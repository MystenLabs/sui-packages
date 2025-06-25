module 0xf634eb82a040b46d1015e90b8b3a7ea57787c664e3c176c0fb1d2bda89debac::fin {
    struct FIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIN>(arg0, 6, b"FIN", b"SuiFin", b"Hey $FIN fam!  Our FIN shark is sprinting, Sui waves are crashing! Hop on board with FIN to \"ignite\" the market! For those without FIN, hurry up and ape in!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaijgvakylkelqmz27gf54kxsu3y2eayovhcyqel6e5nqcfcxbaui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


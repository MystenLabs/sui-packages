module 0xc97664f98c4ed934d100cedb3e0df8e39e69b2242cc35b95738e12cdbe5a664b::wetc {
    struct WETC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETC>(arg0, 6, b"WETC", b"WETCOIN", x"574554434f494e20666f72206c6f6e677465726d0a524541445920544f2050415920444558204f4e434520424f4e4445440a524541445920544f2042555920424f4f535420564f4c554d45204f4e434520424f4e444544", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/waet_72f7883d7c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WETC>>(v1);
    }

    // decompiled from Move bytecode v6
}


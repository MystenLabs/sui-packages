module 0xcdef75d1dcf0b8766a3509fd559a85a39c6318f1fcbab295796991a24a22c0bf::suitrle {
    struct SUITRLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRLE>(arg0, 9, b"SUITRLE", b"Suitrle", b"Keep it cool! Suitrle splashes your portfolio with good luck and waves of meme power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreibw6idu4raryxockambilppp2z6w7tzvomad5fndz6chey7drifzq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITRLE>(&mut v2, 1000000000000000000, @0x4c7df437573b3f1720a6b4d3c0b32adfc5977d97468bdecb80bc1765d79b0aa4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRLE>>(v1);
    }

    // decompiled from Move bytecode v6
}


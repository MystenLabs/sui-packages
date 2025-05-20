module 0xdc7629a248831ae30b28aa89b3d532772ffa3bf86574b2d93d258c3aab46b822::suitrle {
    struct SUITRLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRLE>(arg0, 9, b"SUITRLE", b"Suitrle", b"Keep it cool! Suitrle splashes your portfolio with good luck and waves of meme power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreibw6idu4raryxockambilppp2z6w7tzvomad5fndz6chey7drifzq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITRLE>(&mut v2, 1000000000000000000, @0x6afca50c06d28a36e5c975d4e2b5de337f68140286598f3fc68d6210008ab628, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRLE>>(v1);
    }

    // decompiled from Move bytecode v6
}


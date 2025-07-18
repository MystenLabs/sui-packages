module 0xa26a41180d33544f7e65adde0567fe6e7ccedaeb7e928e7b24d8a94b32206b43::suitrle {
    struct SUITRLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRLE>(arg0, 9, b"SUITRLE", b"Suitrle", b"Keep it cool! Suitrle splashes your portfolio with good luck and waves of meme power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreibw6idu4raryxockambilppp2z6w7tzvomad5fndz6chey7drifzq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITRLE>(&mut v2, 1000000000000000000, @0x86d23a68cdddbdb748c8d40aa226afed8e5f87c5d5dc8e904c13971759339c73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRLE>>(v1);
    }

    // decompiled from Move bytecode v6
}


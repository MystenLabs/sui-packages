module 0xa1958af07cdfa89145313ae5a475be84af2faef6272113afc47ee49cc2d3856::raichu {
    struct RAICHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAICHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAICHU>(arg0, 9, b"RAICHU", b"Raichu", b"Raichu token - an electrifying asset on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreihfsflr4x5whe5hkmdfsg2cbkv6sgnghybucnzddeer6nuipjircu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAICHU>(&mut v2, 1000000000000000000, @0xf5ff1294fe051b94aa74e3f9344e31b5d00fd49a277e2f97f95880138885391e, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAICHU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAICHU>>(v1);
    }

    // decompiled from Move bytecode v6
}


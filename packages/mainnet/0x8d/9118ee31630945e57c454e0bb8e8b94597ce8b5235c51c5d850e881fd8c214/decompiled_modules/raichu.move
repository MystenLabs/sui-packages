module 0x8d9118ee31630945e57c454e0bb8e8b94597ce8b5235c51c5d850e881fd8c214::raichu {
    struct RAICHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAICHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAICHU>(arg0, 9, b"RAICHU", b"Raichu", b"Raichu token - an electrifying asset on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreihfsflr4x5whe5hkmdfsg2cbkv6sgnghybucnzddeer6nuipjircu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAICHU>(&mut v2, 1000000000000000000, @0x6afca50c06d28a36e5c975d4e2b5de337f68140286598f3fc68d6210008ab628, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAICHU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAICHU>>(v1);
    }

    // decompiled from Move bytecode v6
}


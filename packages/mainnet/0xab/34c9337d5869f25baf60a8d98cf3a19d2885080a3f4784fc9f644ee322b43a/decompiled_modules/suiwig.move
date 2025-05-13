module 0xab34c9337d5869f25baf60a8d98cf3a19d2885080a3f4784fc9f644ee322b43a::suiwig {
    struct SUIWIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIG>(arg0, 6, b"SUIWIG", b"Suiwig Ponzi", b"$SUIWIG building ponzi pokemon game on SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie3wggeffn2u3ctgzh2pzq5bhpowoyqjheo6vathvhu2st7xsvway")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIWIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


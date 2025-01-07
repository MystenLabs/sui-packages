module 0x5c8b5872e50199c28b467db7793b88dbf425e9aa2e393e0f63888636eefe4462::grinchtoken {
    struct GRINCHTOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn_tokens(arg0: &mut 0x2::coin::TreasuryCap<GRINCHTOKEN>, arg1: 0x2::coin::Coin<GRINCHTOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GRINCHTOKEN>(arg0, arg1);
    }

    public fun get_token_metadata() : (vector<u8>, vector<u8>, u64) {
        (b"GrinchToken", b"GRINCH", 10000000)
    }

    fun init(arg0: GRINCHTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        init_internal(arg0, arg1);
    }

    fun init_internal(arg0: GRINCHTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINCHTOKEN>(arg0, 3, b"GrinchToken", b"GRINCH", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeidfkub5ien6b4jyretko3mp6jvq53xnoi4mxiprg2gp7j5gzgzsge.ipfs.w3s.link/image.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRINCHTOKEN>>(v1);
        0x2::coin::mint_and_transfer<GRINCHTOKEN>(&mut v2, 10000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINCHTOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_with_fee(arg0: 0x2::coin::Coin<GRINCHTOKEN>, arg1: &mut 0x2::coin::TreasuryCap<GRINCHTOKEN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GRINCHTOKEN>(arg1, 0x2::coin::split<GRINCHTOKEN>(&mut arg0, 0x2::coin::value<GRINCHTOKEN>(&arg0) / 1000, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<GRINCHTOKEN>>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}


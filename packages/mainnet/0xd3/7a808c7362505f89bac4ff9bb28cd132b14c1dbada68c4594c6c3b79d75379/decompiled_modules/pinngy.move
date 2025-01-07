module 0xd37a808c7362505f89bac4ff9bb28cd132b14c1dbada68c4594c6c3b79d75379::pinngy {
    struct PINNGY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PINNGY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PINNGY>>(0x2::coin::mint<PINNGY>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: PINNGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINNGY>(arg0, 9, b"PINNGY", b"PINNGY", b"Suiper Pinngy NFTs coming to sui exposure, with ability to cross-chain development", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1688084111074951168/JQ4DPg-c_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINNGY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINNGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINNGY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}


module 0x8ded946aec9d170ed297b7e42ce9c837e6b411cea08f94185fc6e6b8609ffe8e::suiape {
    struct SUIAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAPE>(arg0, 9, b"SUIAPE", b"Bored Ape on SUI", b"ee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIAPE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x2bb27370503e4a61855cd67ed052e2aa466e1233d8e46b5ef35500d4de0f3f53::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIX>, arg1: 0x2::coin::Coin<SUIX>) {
        0x2::coin::burn<SUIX>(arg0, arg1);
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX>(arg0, 6, b"SUIX", b"SUIX", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tickerperry.xyz/suix.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIX>>(v1);
        0x2::coin::mint_and_transfer<SUIX>(&mut v2, 21000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


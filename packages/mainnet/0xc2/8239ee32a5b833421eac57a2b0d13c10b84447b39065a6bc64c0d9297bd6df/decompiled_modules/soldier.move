module 0xc28239ee32a5b833421eac57a2b0d13c10b84447b39065a6bc64c0d9297bd6df::soldier {
    struct SOLDIER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SOLDIER>, arg1: 0x2::coin::Coin<SOLDIER>) {
        0x2::coin::burn<SOLDIER>(arg0, arg1);
    }

    fun init(arg0: SOLDIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLDIER>(arg0, 6, b"SOLDIER", b"SOLDIER", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suisoldier.xyz/suisoldier.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLDIER>>(v1);
        0x2::coin::mint_and_transfer<SOLDIER>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLDIER>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOLDIER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SOLDIER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


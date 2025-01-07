module 0x10cd6b60ad762c8a539768b765c2a6b627eb49a8a5add9ab627e3aa2c2f1656f::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SPEPE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SPEPE>>(arg0, arg1);
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 6, b"$PEPE", b"PepeSui", b"Pepe SUI rose to the occasion & wowed everyone with his stupidity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/cG7A2nV.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SPEPE>(&mut v2, 600000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}


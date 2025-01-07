module 0xff0221d56f7c72ea960268b6aa5dbb5264cad980ff569fede88dbaf46fe259c6::hkdoll {
    struct HKDOLL has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HKDOLL>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HKDOLL>>(0x2::coin::mint<HKDOLL>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<HKDOLL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKDOLL>>(arg0, arg1);
    }

    fun init(arg0: HKDOLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKDOLL>(arg0, 8, b"HKDOLL", b"Hong Kong Doll", b"Hong Kong Doll Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1465428707376463874/LCPoV8AW_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HKDOLL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKDOLL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


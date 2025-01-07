module 0xed4b1dbcc319b713bd2ab82b545419ad9a064f42464e132b9b7b59f0fd905192::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WOJAK>, arg1: 0x2::coin::Coin<WOJAK>) {
        0x2::coin::burn<WOJAK>(arg0, arg1);
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<WOJAK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WOJAK>(arg0, 1000000, arg2, arg3);
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK>(arg0, 6, b"WOJAK", b"WOJAK", b"Wojaks are happy at sunrise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"imgur.com/a/hbLc4Sk")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOJAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


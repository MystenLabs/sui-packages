module 0x1cef1279077f8d1d4c36c598b79f43582c1dcab0d36025118a96c156c8f3b358::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: 0x2::coin::Coin<PEPE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<PEPE>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE>>(0x2::coin::mint<PEPE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 9, b"PEPE-DREAM", b"PEPE", b"PEPE DREAM MEME TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/raidenx-no-cors/token-icons/pepe-dream.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, @0x351b556d6a0dad25ecd968c205f418c2a26beb3c407eefa9525198de7156e91a);
    }

    // decompiled from Move bytecode v6
}


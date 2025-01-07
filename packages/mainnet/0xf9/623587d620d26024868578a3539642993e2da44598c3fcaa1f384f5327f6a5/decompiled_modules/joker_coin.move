module 0xf9623587d620d26024868578a3539642993e2da44598c3fcaa1f384f5327f6a5::joker_coin {
    struct JOKER_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JOKER_COIN>, arg1: 0x2::coin::Coin<JOKER_COIN>) {
        0x2::coin::burn<JOKER_COIN>(arg0, arg1);
    }

    fun init(arg0: JOKER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER_COIN>(arg0, 6, b"JOKER", b"JOKER", b"learning for letsmove, power by alva-lin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-d12507e471ea44b89eaa8d48d6397520.r2.dev/joker.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKER_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOKER_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JOKER_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


module 0xcecb963a22222a68d1c525836ff58f253f63a369cb923bfaa7e129a3ae08f43a::futuwxq_coin {
    struct FUTUWXQ_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FUTUWXQ_COIN>, arg1: 0x2::coin::Coin<FUTUWXQ_COIN>) {
        0x2::coin::burn<FUTUWXQ_COIN>(arg0, arg1);
    }

    fun init(arg0: FUTUWXQ_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUTUWXQ_COIN>(arg0, 9, b"FUTUWXQ_COIN", b"FUTUWXQ", b"futuwxq coin, my first ft coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/49089070")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUTUWXQ_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUTUWXQ_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FUTUWXQ_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FUTUWXQ_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


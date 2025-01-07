module 0xc60adef0aaa6304737d333161c096ec51077e33cde1074a7a9fdd298a013d391::fyj1230_coin {
    struct FYJ1230_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FYJ1230_COIN>, arg1: 0x2::coin::Coin<FYJ1230_COIN>) {
        0x2::coin::burn<FYJ1230_COIN>(arg0, arg1);
    }

    fun init(arg0: FYJ1230_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYJ1230_COIN>(arg0, 9, b"FYJ1230_COIN", b"fyj1230", b"virtual coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167277561")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FYJ1230_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYJ1230_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FYJ1230_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FYJ1230_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


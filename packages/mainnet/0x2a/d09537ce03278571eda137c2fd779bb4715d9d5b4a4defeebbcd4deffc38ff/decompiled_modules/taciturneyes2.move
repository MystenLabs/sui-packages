module 0x2ad09537ce03278571eda137c2fd779bb4715d9d5b4a4defeebbcd4deffc38ff::taciturneyes2 {
    struct TACITURNEYES2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TACITURNEYES2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TACITURNEYES2>(arg0, 8, b"TACI", b"taciturneyes coin2", b"this is a taciturneyes coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/77370454?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TACITURNEYES2>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TACITURNEYES2>>(v0);
    }

    public entry fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


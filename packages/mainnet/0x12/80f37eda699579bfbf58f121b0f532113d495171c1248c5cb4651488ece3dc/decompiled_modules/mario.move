module 0x1280f37eda699579bfbf58f121b0f532113d495171c1248c5cb4651488ece3dc::mario {
    struct MARIO has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"MARIO", b"MARIO SUI LOVE", b"MARIO IS THE SUI LOVE SYMBOL OF SUUUUUUUUWEEEEEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wallpapers-clan.com/wp-content/uploads/2024/03/mario-pfp-01.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    public entry fun confirm(arg0: &mut 0x2::coin::TreasuryCap<MARIO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MARIO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<MARIO>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


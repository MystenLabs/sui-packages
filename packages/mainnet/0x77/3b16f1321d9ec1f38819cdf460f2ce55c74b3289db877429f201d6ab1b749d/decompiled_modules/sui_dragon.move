module 0x773b16f1321d9ec1f38819cdf460f2ce55c74b3289db877429f201d6ab1b749d::sui_dragon {
    struct SUI_DRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_DRAGON>(arg0, 9, b"SUI DRAGON", x"f09f908953756920447261676f6e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_DRAGON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_DRAGON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_DRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}


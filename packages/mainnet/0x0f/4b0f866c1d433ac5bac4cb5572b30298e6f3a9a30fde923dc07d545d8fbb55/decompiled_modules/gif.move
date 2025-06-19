module 0xf4b0f866c1d433ac5bac4cb5572b30298e6f3a9a30fde923dc07d545d8fbb55::gif {
    struct GIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIF>(arg0, 8, b"gif", b"gorbagana wif hat", b"gorbagana wif", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/7fe921a9-4b03-42ba-88f9-d94cd2d8160f.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GIF>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIF>>(v1);
    }

    // decompiled from Move bytecode v6
}


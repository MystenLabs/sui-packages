module 0xe3d02fdae4ac9ec18b4874183076d791f83f5462753610f276f555d45d57db98::gld {
    struct GLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLD>(arg0, 9, b"GLD", b"Sui Golden Coin", b"Golden Coin for everyone everywhere", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/J7ZLT5x.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<GLD>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLD>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLD>>(v1);
    }

    // decompiled from Move bytecode v6
}


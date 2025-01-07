module 0xe55d2c9538fa8a4bf6bde7e2de6ea356d237fd033556125309fcbd8c75a63059::too {
    struct TOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOO>(arg0, 9, b"TOO", b"TOO", b"TIP meme uniswap v2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://forkast.news/wp-content/uploads/2023/10/Sui-network.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOO>>(v2, @0xb0a219a9d7cbcc095ef5f7dd2502b589c54a1553a5c945dae7bd385e93239ddc);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOO>>(v1);
    }

    // decompiled from Move bytecode v6
}


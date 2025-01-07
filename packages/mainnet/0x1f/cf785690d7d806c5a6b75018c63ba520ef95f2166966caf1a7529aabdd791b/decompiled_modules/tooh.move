module 0x1fcf785690d7d806c5a6b75018c63ba520ef95f2166966caf1a7529aabdd791b::tooh {
    struct TOOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOOH>(arg0, 9, b"TOOH", b"TOOH", b"TIP meme uniswap v2 for test init price", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://forkast.news/wp-content/uploads/2023/10/Sui-network.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOOH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOOH>>(v2, @0xb0a219a9d7cbcc095ef5f7dd2502b589c54a1553a5c945dae7bd385e93239ddc);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOOH>>(v1);
    }

    // decompiled from Move bytecode v6
}


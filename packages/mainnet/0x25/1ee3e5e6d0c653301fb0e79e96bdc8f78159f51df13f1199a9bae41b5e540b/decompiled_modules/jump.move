module 0x251ee3e5e6d0c653301fb0e79e96bdc8f78159f51df13f1199a9bae41b5e540b::jump {
    struct JUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMP>(arg0, 6, b"JUMP", b"JUMPER", b"A truly multi-chain exchange. Aggregating the best in the business for bridging, swapping, onramping. Live on Bitcoin, EVM and Solana!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730998686318.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


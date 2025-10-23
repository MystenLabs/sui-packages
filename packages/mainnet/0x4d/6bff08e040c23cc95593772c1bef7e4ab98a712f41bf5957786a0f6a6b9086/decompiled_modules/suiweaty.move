module 0x4d6bff08e040c23cc95593772c1bef7e4ab98a712f41bf5957786a0f6a6b9086::suiweaty {
    struct SUIWEATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWEATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWEATY>(arg0, 9, b"SUIWEATY", b"SUIWEATY", b"SUIWEATY coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761161537/sui_tokens/qnz4qzseglengkstklyi.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIWEATY>>(0x2::coin::mint<SUIWEATY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIWEATY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIWEATY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


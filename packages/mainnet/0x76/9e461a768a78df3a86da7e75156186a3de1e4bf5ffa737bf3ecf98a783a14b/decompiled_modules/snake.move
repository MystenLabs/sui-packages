module 0x769e461a768a78df3a86da7e75156186a3de1e4bf5ffa737bf3ecf98a783a14b::snake {
    struct SNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKE>(arg0, 0, b"SNAKE", b"SNAKE", b"SNAKE EAT LIZARD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://meme.rolipoli.xyz/meme-icons/1758484857032_a0e9208c-2455-45a5-8e2c-9760ae2470cc.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SNAKE>>(0x2::coin::mint<SNAKE>(&mut v2, 999, arg1), @0x6dc40a6b35310e5dd5cb7767f8d8477b9c1fc219f0cc511f45928eddaae341dd);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SNAKE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}


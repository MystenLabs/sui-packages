module 0xd9ab22c81edf305ab6eb0162032e9a6abb33dd880fd2a0d95ea0a661b89f3d21::samab {
    struct SAMAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMAB>(arg0, 9, b"SAMAB", b"SAMAB", b"SAMAB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/fzSKx-gAjEeu2LLN9jjNL7SsVnOG-9BMEvyiZssbhFU")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SAMAB>>(0x2::coin::mint<SAMAB>(&mut v2, 5000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAMAB>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAMAB>>(v1);
    }

    // decompiled from Move bytecode v7
}


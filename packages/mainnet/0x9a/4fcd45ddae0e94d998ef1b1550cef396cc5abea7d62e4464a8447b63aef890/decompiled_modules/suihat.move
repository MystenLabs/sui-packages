module 0x9a4fcd45ddae0e94d998ef1b1550cef396cc5abea7d62e4464a8447b63aef890::suihat {
    struct SUIHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHAT>(arg0, 9, b"SUIHAT", b"Sui Hat", b"The most famous Hat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/8crJDdBb/hat-1.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIHAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


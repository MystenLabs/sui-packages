module 0xb3434d951a134bb9be9b60ef65cd0662643c3c6dd56c8e539ec2a7745843bc84::bubcoin {
    struct BUBCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBCOIN>(arg0, 9, b"BUB", b"Bubcoin", b"A peer-to-peer bubble mining system. 21M hard cap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bublz.fun/bubcoin.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun max_supply() : u64 {
        21000000000000000
    }

    // decompiled from Move bytecode v6
}


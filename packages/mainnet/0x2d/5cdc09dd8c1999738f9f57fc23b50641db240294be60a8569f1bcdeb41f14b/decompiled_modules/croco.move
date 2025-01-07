module 0x2d5cdc09dd8c1999738f9f57fc23b50641db240294be60a8569f1bcdeb41f14b::croco {
    struct CROCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCO>(arg0, 6, b"CROCO", b"CROCO", b"Hi, I'm CROCO on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/SPdvRrh/ava.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CROCO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCO>>(v1);
    }

    // decompiled from Move bytecode v6
}


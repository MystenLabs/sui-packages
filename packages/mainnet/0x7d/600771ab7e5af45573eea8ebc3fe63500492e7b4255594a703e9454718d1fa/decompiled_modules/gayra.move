module 0x7d600771ab7e5af45573eea8ebc3fe63500492e7b4255594a703e9454718d1fa::gayra {
    struct GAYRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAYRA>(arg0, 6, b"GAYRA", b"Gay Wara", b"Hi! I am little wara, nobody gives me supply anymore, I've had enough of you guys. I just deleted my X.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihxjsocqga7hqbprvtrykiecd7sgubhwdmcq574oxs2hdicjtmrve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAYRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAYRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


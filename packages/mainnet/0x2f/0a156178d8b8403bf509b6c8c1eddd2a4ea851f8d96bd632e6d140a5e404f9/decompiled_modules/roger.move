module 0x2f0a156178d8b8403bf509b6c8c1eddd2a4ea851f8d96bd632e6d140a5e404f9::roger {
    struct ROGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROGER>(arg0, 6, b"ROGER", b"Roger On Sui", b"ROGER ROGER FOUND IN AMERICAN DAD BY SUI MACFARLANE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_12_3cc58ad584.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROGER>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xed4eaa4bffc90aeac2aadcd2f49f250529aa96b61a7b0610b8ca105f82d23452::roger {
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


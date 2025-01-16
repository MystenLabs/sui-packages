module 0x164e9e69fb97aecc34342b83d604b3ae46a4ef064936000fb5bbfea721a6f630::aicat {
    struct AICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AICAT>(arg0, 6, b"AICAT", b"Cat AI Sui Network", b"The AI Meme Token for the Community on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_Ib9q6_AZ_400x400_1_c0abf879a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


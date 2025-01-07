module 0xf0e42662f5fd6b028066939544b1a82e66a2e935c2575002656827a427f92bc0::dap {
    struct DAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAP>(arg0, 6, b"DAP", b"DonaldArielPooh", b"Donald Duck, Ariel the Little Mermaid, and Winnie the Pooh invite you to come party. Dance with us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_12_02_15_34_fb262ec418.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAP>>(v1);
    }

    // decompiled from Move bytecode v6
}


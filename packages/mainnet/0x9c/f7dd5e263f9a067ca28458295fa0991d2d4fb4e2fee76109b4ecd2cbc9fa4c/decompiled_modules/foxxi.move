module 0x9cf7dd5e263f9a067ca28458295fa0991d2d4fb4e2fee76109b4ecd2cbc9fa4c::foxxi {
    struct FOXXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXXI>(arg0, 9, b"FOXXI", b"Sui Fox", b"SuiFox is a swift and clever token, embodying the agility of a fox. Built on the Sui blockchain, it offers fast transactions, security, and adaptability, making it ideal for staying ahead in the decentralized finance space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1828379187285028864/EMXfMdm3.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOXXI>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXXI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXXI>>(v1);
    }

    // decompiled from Move bytecode v6
}


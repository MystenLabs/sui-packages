module 0xa1f7b99010d555df03d80770783c8df8a4d711fa11d3b759c92338de1ef8ba9::popcat {
    struct POPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POPCAT>(arg0, 6, 0x1::string::utf8(b"POPCAT"), 0x1::string::utf8(b"Popular Suicat"), 0x1::string::utf8(x"69747320746865206d6f737420706f70756c61722073756920636174206f6e2077686f6c652073756920636861696e0a7374616b652024504f50434154206561726e2024535549"), 0x1::string::utf8(b"https://popularsui.xyz/media/366cb77c0ba2dd196ebf99fd5492eb1f34c49780f217b780fbe952fe2f9b5e2e.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POPCAT>>(0x2::coin_registry::finalize<POPCAT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


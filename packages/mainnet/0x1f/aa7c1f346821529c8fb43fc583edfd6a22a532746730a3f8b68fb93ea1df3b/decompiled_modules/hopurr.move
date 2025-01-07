module 0x1faa7c1f346821529c8fb43fc583edfd6a22a532746730a3f8b68fb93ea1df3b::hopurr {
    struct HOPURR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPURR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPURR>(arg0, 6, b"HOPURR", b"Hopurr on Sui", x"536875742024484f5020262074616b65206d79206d6f6e6579210a0a47657420696e2074686520486f7075727220747261696e2e20484f5020746865206761696e732e200a0a426520637574652c20736d6172742c20666173742c20707265636973652c20616e642067726f77696e67206c696b652023486f707572722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050426_102f6c79d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPURR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPURR>>(v1);
    }

    // decompiled from Move bytecode v6
}


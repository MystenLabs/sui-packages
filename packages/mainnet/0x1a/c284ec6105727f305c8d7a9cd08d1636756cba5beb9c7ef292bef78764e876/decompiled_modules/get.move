module 0x1ac284ec6105727f305c8d7a9cd08d1636756cba5beb9c7ef292bef78764e876::get {
    struct GET has drop {
        dummy_field: bool,
    }

    fun init(arg0: GET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GET>(arg0, 6, b"GET", b"Get AI", b"Get AI is an algorithm created to profit from the volatility of its own asset. The mission is to explore, implement, and guide the creation of a secure, efficient, and decentralized digital ecosystem. Get AI also offers various utilities that enhance the functionality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GET_b4c3afe05e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GET>>(v1);
    }

    // decompiled from Move bytecode v6
}


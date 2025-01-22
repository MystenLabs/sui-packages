module 0xcb993eb39d088056a9125f10803e56e98eea4d67a89e18c8fc10571c078e42e::wls {
    struct WLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLS>(arg0, 6, b"WLS", b"World Liberty SUI", b"Discover World Liberty Sui, the cutting-edge DeFi platform supported by Donald J. Trump. Connecting you with decentralized finances best tools for secure, high-yield crypto investments. Join the financial revolution today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WLS_cb9ff4d3c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLS>>(v1);
    }

    // decompiled from Move bytecode v6
}


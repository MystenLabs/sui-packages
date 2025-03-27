module 0x1179e236a1c7d7975c381a17e3335dacf5e6d55e9cbce60789d014f0d891579::taw {
    struct TAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAW>(arg0, 6, b"TAW", b"The Acid Walrus", b"$TAW launched on movepump platform, which is safe for both Devs/Users, implementing a Fair Launch with no team allocations and a Bonding Curve.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076352_57fdbd9132.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAW>>(v1);
    }

    // decompiled from Move bytecode v6
}


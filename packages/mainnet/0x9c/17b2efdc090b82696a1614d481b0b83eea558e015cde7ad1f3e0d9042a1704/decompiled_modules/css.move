module 0x9c17b2efdc090b82696a1614d481b0b83eea558e015cde7ad1f3e0d9042a1704::css {
    struct CSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSS>(arg0, 6, b"CSS", b"Chop Suey Sui", x"57616b65207570202877616b65207570290a47726162206120627275736820616e64207075742061206c6974746c65206d616b652d75700a486964652074686520736361727320746f2066616465206177617920746865207368616b652d75702028686964652074686520736361727320746f20666164652061776179207468652d290a576879276420796f75206c6561766520746865206b6579732075706f6e20746865207461626c653f0a4865726520796f7520676f2063726561746520616e6f74686572206661626c652c20796f752077616e74656420746f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_22_11_00_30_PM_a883b0e716.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSS>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xb3e3bb04e32d66371ff4560adad6e7c51e818f77b58919b293bdc8142db21220::peperoshi {
    struct PEPEROSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEROSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEROSHI>(arg0, 6, b"PEPEROSHI", b"PepeRoshi Token", x"4865726d697420616e64206d6173746572206f66206d61727469616c2061727473206675656c6564206f6e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pepe_Roshi_46e436bedd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEROSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEROSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}


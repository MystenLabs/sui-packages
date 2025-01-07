module 0x1be48e9006687b5f057f48fd85d5c80e041425da6a3820d439093b87baf4c50::baa {
    struct BAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAA>(arg0, 6, b"BAA", b"Before And After", b"We all do it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005153_1d112468ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAA>>(v1);
    }

    // decompiled from Move bytecode v6
}


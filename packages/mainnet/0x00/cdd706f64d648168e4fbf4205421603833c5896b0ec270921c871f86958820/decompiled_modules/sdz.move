module 0xcdd706f64d648168e4fbf4205421603833c5896b0ec270921c871f86958820::sdz {
    struct SDZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDZ>(arg0, 6, b"Sdz", b"test", b"qsQS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aafb228def8cc26f43aa59c807f5206b_e426953e76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDZ>>(v1);
    }

    // decompiled from Move bytecode v6
}


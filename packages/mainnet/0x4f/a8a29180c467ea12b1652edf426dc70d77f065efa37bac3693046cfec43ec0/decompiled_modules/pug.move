module 0x4fa8a29180c467ea12b1652edf426dc70d77f065efa37bac3693046cfec43ec0::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 1, b"PUG", b"PUG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUG>(&mut v2, 5000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUG>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x66cc3e87486e4c1e9bfddcf1ce3722c12205982149913b8ad4183039dde2389a::done {
    struct DONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONE>(arg0, 1, b"DONE", b"DONE", x"444f4ec2a3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DONE>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONE>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xacbde3759e2e0bff4b5e3d01e41cbde176d1e18a1694d23be288b8c47842f641::r1 {
    struct R1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: R1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R1>(arg0, 9, b"R1", b"RZ1AWO", b"token of radio community from Saint-Petersburg, Russia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f3361f4c3b250af32f2b2e6eff8b75a3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


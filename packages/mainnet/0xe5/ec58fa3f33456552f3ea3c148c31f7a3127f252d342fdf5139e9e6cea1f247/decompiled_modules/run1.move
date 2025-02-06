module 0xe5ec58fa3f33456552f3ea3c148c31f7a3127f252d342fdf5139e9e6cea1f247::run1 {
    struct RUN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUN1>(arg0, 9, b"run1", b"run1", b"run1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"run1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUN1>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUN1>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RUN1>>(v2);
    }

    // decompiled from Move bytecode v6
}


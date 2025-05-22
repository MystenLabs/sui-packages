module 0x3253521cb4f0f1699e5f641047fe8e476fa4328c3d2103ac34e2ed64d22c5b03::pog {
    struct POG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POG>(arg0, 9, b"Pog", b"Pog", b"Meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/e8683cae-8420-4332-8e1b-ef0be49b2c5e.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POG>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POG>>(v1);
    }

    // decompiled from Move bytecode v6
}


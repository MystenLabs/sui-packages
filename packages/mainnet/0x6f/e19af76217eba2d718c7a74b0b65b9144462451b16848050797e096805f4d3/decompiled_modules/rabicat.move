module 0x6fe19af76217eba2d718c7a74b0b65b9144462451b16848050797e096805f4d3::rabicat {
    struct RABICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABICAT>(arg0, 6, b"RabiCat", b"Rabbit Cat", b"Rabbit ears with a cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731998154923.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RABICAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABICAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x344382d7e7741c16b34693a6d16362d800c79b9e6101ad64715723a740e1ad01::now {
    struct NOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOW>(arg0, 9, b"now", b"now", b"test coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"asdasdasdas")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOW>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOW>>(v1);
    }

    // decompiled from Move bytecode v6
}


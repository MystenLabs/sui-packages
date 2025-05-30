module 0xe462eb2e476cbd5a04650262a960c941588c953ba8b23292e7aaad4fbb3a207f::TEST {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = mint(arg0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST>>(v0);
    }

    public fun mint(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<TEST>, 0x2::coin::CoinMetadata<TEST>) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", b"TEST", b"Test Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.istockphoto.com/id/1045035708/vector/duckling-simple-vector-icon.jpg?s=612x612&w=0&k=20&c=DPyR6_meVD32JBRKEZiwrAkn0kFY5PT4qxiQblfqkjs=")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 1000000000000000000, @0xec5d50176166ef77b8188f2a13702c0584e771b96af14fc641dfbeddd00863de, arg1);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}


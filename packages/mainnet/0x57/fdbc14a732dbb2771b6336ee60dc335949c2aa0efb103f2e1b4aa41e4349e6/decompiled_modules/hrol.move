module 0x57fdbc14a732dbb2771b6336ee60dc335949c2aa0efb103f2e1b4aa41e4349e6::hrol {
    struct HROL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HROL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HROL>(arg0, 9, b"Hrol", b"troltest", b"its a test just chill.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HROL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HROL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HROL>>(v1);
    }

    // decompiled from Move bytecode v6
}


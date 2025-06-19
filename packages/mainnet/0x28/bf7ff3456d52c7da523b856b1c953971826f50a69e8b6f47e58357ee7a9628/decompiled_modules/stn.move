module 0x28bf7ff3456d52c7da523b856b1c953971826f50a69e8b6f47e58357ee7a9628::stn {
    struct STN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STN>(arg0, 6, b"STN", b"S Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/eeb27070-446d-4069-af2c-9fe13c6dbb81.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STN>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STN>>(v1);
    }

    // decompiled from Move bytecode v6
}


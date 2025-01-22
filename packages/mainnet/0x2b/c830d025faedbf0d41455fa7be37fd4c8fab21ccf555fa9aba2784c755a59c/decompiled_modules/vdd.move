module 0x2bc830d025faedbf0d41455fa7be37fd4c8fab21ccf555fa9aba2784c755a59c::vdd {
    struct VDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VDD>(arg0, 5, b"VDD", b"duc", x"c3a16464c3a164", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/d0022430-d896-11ef-9ad1-d96ea2b1225f")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VDD>>(v1);
        0x2::coin::mint_and_transfer<VDD>(&mut v2, 110000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VDD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}


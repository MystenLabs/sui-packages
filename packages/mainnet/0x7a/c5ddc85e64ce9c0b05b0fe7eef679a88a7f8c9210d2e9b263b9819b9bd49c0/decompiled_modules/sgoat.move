module 0x7ac5ddc85e64ce9c0b05b0fe7eef679a88a7f8c9210d2e9b263b9819b9bd49c0::sgoat {
    struct SGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOAT>(arg0, 9, b"SGOAT", b"Stand Goat", x"6576696c207369676e20f09f9888", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/Ms6f1hm/standgoatt.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SGOAT>(&mut v2, 777777777000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


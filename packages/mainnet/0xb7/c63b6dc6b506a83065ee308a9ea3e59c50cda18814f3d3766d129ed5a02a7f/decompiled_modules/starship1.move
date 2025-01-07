module 0xb7c63b6dc6b506a83065ee308a9ea3e59c50cda18814f3d3766d129ed5a02a7f::starship1 {
    struct STARSHIP1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARSHIP1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARSHIP1>(arg0, 6, b"STARSHIP1", b"STARSHIP", b"Elon Mask STARSHIP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mask_f850b7e7af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARSHIP1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARSHIP1>>(v1);
    }

    // decompiled from Move bytecode v6
}


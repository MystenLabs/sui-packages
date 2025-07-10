module 0xfe2febaebbb69b266542f02682fec706dabf9c38449339ba9b38e9cfbfc439a6::gf4 {
    struct GF4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GF4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GF4>(arg0, 6, b"GF4", b"GrokFor", b"4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/inv_ore_copper_01_a6b631b1a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GF4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GF4>>(v1);
    }

    // decompiled from Move bytecode v6
}


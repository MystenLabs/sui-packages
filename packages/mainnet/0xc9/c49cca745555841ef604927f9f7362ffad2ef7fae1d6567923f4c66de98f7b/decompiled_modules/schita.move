module 0xc9c49cca745555841ef604927f9f7362ffad2ef7fae1d6567923f4c66de98f7b::schita {
    struct SCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHITA>(arg0, 6, b"SCHITA", b"SUICHITA", b" Pochita of Sui ($SUICHITA)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_5_d2a8f29b0c_86f61ac83c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}


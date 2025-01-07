module 0x44354675f48247d92618608a67d50321b09d20106633a0df947bdd6aefb10afc::monie {
    struct MONIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONIE>(arg0, 6, b"MONIE", b"Monie on Sui", b"Why are there only Washington, Franklin and Lincoln on the dollar? Redesign the US Dollar with Monies face front and center.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_logo_180x180_d6cb59ad02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONIE>>(v1);
    }

    // decompiled from Move bytecode v6
}


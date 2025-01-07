module 0xa9c8197d57d74a10f17545f493f8be39bd8de411f309474af15bb4a59b776307::turtel {
    struct TURTEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTEL>(arg0, 6, b"TURTEL", b"Turtel", b"The first blue turtle on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_14_00_16_50_545_edit_com_miui_mediaeditor_f4ea73db9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTEL>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x19481fbef003fc2a389264956db936c91ffd2c820b94d50482dd079e3bd1a696::bobsui {
    struct BOBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBSUI>(arg0, 6, b"BOBSUI", b"BOBAONSUI", x"424f424120554e444552205741544552204a555354204d454d45434f494e0a4c455453204d414b4520495420414c4c204d4f4f4e205749544820535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/png_clipart_blue_bubbles_blue_floating_water_bubbles_sphere_material_thumbnail_removebg_preview_e205a30219.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


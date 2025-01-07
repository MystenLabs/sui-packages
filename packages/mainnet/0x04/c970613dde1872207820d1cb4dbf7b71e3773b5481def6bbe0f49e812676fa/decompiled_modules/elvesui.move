module 0x4c970613dde1872207820d1cb4dbf7b71e3773b5481def6bbe0f49e812676fa::elvesui {
    struct ELVESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELVESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELVESUI>(arg0, 6, b"ELVESUI", b"Elves on SUI", b"$Elves unleashing holiday magic - you won't want to miss this drop!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gd_TWUVU_Xg_AA_Hx_OW_76a5a479db.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELVESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELVESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x9a39dbd4594b5c804f913830830192db81fc134c1294f4b61886171be9f703dd::lasui {
    struct LASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LASUI>(arg0, 6, b"LASUI", b"LABUSUI", b"LABUBU ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2_f1334bebe4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


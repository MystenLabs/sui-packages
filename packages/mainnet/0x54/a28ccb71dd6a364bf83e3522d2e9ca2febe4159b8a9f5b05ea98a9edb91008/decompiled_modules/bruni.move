module 0x54a28ccb71dd6a364bf83e3522d2e9ca2febe4159b8a9f5b05ea98a9edb91008::bruni {
    struct BRUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUNI>(arg0, 6, b"BRUNI", b"BRUNI SUI", b"Bruni is a character in Disney's 2019 animated feature film Frozen II. A salamander of innocuous appearance, Bruni is an inhabitant of the Enchanted Forest and the elemental spirit of fire. Though shy at first, Bruni quickly bonds to those with the patience to understand him, as Elsa demonstrated.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736555645_305013_9_F7_D30_F9_209_E_4_BDC_B52_F_96_C7_DAB_7_B238_46e2f8a5ce.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}


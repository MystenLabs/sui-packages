module 0x9c594b6d320a6b60c0e5bbdc5aa5fd57f761f219baed0763ca7889e5c6902ab4::eric {
    struct ERIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERIC>(arg0, 6, b"ERIC", b"ERIC THE FISH", x"496d20456c6f6e27732070657420666973682c20244552494320616e642049206b6e6f7720686f7720746f2064726976652e200a0a456c6f6e732054776565743a2068747470733a2f2f782e636f6d2f656c6f6e6d75736b2f7374617475732f313737393431333037383133383037333334383f733d343226743d4d666f364f77434e625f4f516c665a396b7658704767", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b_Kv6_Ffja_400x400_8b064ceef8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERIC>>(v1);
    }

    // decompiled from Move bytecode v6
}


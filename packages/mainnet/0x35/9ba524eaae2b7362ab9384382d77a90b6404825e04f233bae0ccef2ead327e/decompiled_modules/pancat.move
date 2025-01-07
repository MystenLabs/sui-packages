module 0x359ba524eaae2b7362ab9384382d77a90b6404825e04f233bae0ccef2ead327e::pancat {
    struct PANCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANCAT>(arg0, 6, b"PANCAT", b"Sui Pan Cat", b"did you see a pan cat?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/40_BD_1907_ED_0_B_4_CFC_B074_7_F999333_D625_eaeca42a59.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


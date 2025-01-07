module 0x9f6341a4451d7ca774333f02e1017ef60fa71ded96deacb9b9d7fdc3590abcb::suigingcat {
    struct SUIGINGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGINGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGINGCAT>(arg0, 6, b"SuiGingCat", b"Sui Ginger Cat", b"Everybody needs a Sui ginger cat. The ginger cat can't stop thinking about Sui. Keep smiling with your ginger cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gingercat_b3cd83aed4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGINGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGINGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


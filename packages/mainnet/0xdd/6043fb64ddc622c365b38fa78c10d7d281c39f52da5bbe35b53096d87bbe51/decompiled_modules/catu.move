module 0xdd6043fb64ddc622c365b38fa78c10d7d281c39f52da5bbe35b53096d87bbe51::catu {
    struct CATU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATU>(arg0, 6, b"CatU", b"Cat Ultra", b"chat: https://t.me/catultra22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8d2e60b8_99e8_476e_bf1d_12fbdb06f3ea_598a04db39.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATU>>(v1);
    }

    // decompiled from Move bytecode v6
}


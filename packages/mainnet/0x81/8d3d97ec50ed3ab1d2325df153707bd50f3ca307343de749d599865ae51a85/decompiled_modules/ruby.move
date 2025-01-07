module 0x818d3d97ec50ed3ab1d2325df153707bd50f3ca307343de749d599865ae51a85::ruby {
    struct RUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<RUBY>(arg0, 6, b"RUBY", b"Ruby Corp", b"Ruby Corp. is a project specialized in AI customization and privacy - aiming to target the untapped parts big corporations are not focused on for huge upside with little risk. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728131734119_b5ceacfd540ff8d651616b2f3d5df9d7_a25a1c19f9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<RUBY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUBY>>(v2);
    }

    // decompiled from Move bytecode v6
}


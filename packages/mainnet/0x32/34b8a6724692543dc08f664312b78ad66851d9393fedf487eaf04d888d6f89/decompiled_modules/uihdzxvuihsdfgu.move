module 0x3234b8a6724692543dc08f664312b78ad66851d9393fedf487eaf04d888d6f89::uihdzxvuihsdfgu {
    struct UIHDZXVUIHSDFGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UIHDZXVUIHSDFGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UIHDZXVUIHSDFGU>(arg0, 9, b"uihdzxvuihsdfgu", b"uihdzxvuihsdfgu", b"sdfuihdzxvuihsdfgu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui.directory/wp-content/uploads/2023/04/SuiNS_high_res_tw_logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UIHDZXVUIHSDFGU>(&mut v2, 123000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UIHDZXVUIHSDFGU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UIHDZXVUIHSDFGU>>(v1);
    }

    // decompiled from Move bytecode v6
}


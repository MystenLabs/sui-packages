module 0x2e2d394021d7ac8f50c75dd82693fe47c854ab35d20736c37550c3550544a9ac::gm {
    struct GM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GM>(arg0, 6, b"GM", b"Goat Matrix", x"5468617420676f6174206b6e6f7720686f7720746f2066696e6420657869742066726f6d206d61747269780a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdo_Up_H_Pp198_Xnu763_NW_2h_Motk_Qv1a6_Lowb6bw_K_Cwpaa_Di_01da7a663b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GM>>(v1);
    }

    // decompiled from Move bytecode v6
}


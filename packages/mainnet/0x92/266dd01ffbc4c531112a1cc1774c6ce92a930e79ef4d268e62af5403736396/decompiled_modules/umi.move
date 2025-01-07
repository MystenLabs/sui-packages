module 0x92266dd01ffbc4c531112a1cc1774c6ce92a930e79ef4d268e62af5403736396::umi {
    struct UMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UMI>(arg0, 6, b"Umi", b"Umi cat", b"The cutest most memeable cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yga_Cfxas_AI_5_LG_4_e8095f1b91.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UMI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x3e35c86b1a1c5b54b1ecd4cb2419631b3fc4918c6d054c860e523484485fd457::murktat {
    struct MURKTAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURKTAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURKTAT>(arg0, 6, b"MURKTAT", b"MURKATSUI", b"prep the porthole for imminent crypto riches as MURMEWD Kat surfaces with danker Aqua powers in Sui's degen underwater world! This salty feline hero radiates pump energies so royal through his trident, even Aquaman cant compete! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fi_D7511_KA_5_C358_Kgh_Gx_L_Afv6_Eze_W9_Rq_E6_V_Ybxgs_Wzw_PR_copy_8627b702fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURKTAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURKTAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


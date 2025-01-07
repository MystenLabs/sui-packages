module 0x4adbd9e9daa083a4d4f7d407ae021da8b668506af363c9b6454db6541ddffcd::peitra {
    struct PEITRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEITRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEITRA>(arg0, 6, b"PEITRA", b"Peipi Trans", b"peipi trans : first pink ape transsexual meme coin on movepump story of piepi trans In the increasingly crowded world of crypto, a new phenomenon has emerged: PeipiTrans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S_Pznf_Agtk2g_MXT_Kiyk6jfn_X_Ja_Kdofgq9_Xw9che_P_Hr_Ge5_80d5a46947.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEITRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEITRA>>(v1);
    }

    // decompiled from Move bytecode v6
}


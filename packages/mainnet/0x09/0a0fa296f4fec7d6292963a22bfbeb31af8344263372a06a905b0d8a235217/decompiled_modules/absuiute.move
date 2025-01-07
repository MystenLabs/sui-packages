module 0x90a0fa296f4fec7d6292963a22bfbeb31af8344263372a06a905b0d8a235217::absuiute {
    struct ABSUIUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABSUIUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABSUIUTE>(arg0, 6, b"abSUIute", b"abSUIute Degens", x"5468652070657266656374206472696e6b20666f722053554920646567656e732120466f722070726f666974206461696c79207573652c2074616b65203220646f736573202f206461792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xhr_Wfg_H2_GR_9h4jt_H_Sgyy_M_Nwypa91n_Q2_T2fth_Py8hm_Xn2_1_b64e650322.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABSUIUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABSUIUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}


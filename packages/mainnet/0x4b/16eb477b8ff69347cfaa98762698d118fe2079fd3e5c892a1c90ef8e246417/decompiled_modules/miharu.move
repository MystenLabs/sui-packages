module 0x4b16eb477b8ff69347cfaa98762698d118fe2079fd3e5c892a1c90ef8e246417::miharu {
    struct MIHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIHARU>(arg0, 6, b"MIHARU", b"Hanbao on Sui", b"Hanbao on Sui . ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GTFWEV_Qy5_Bw_Qs_ZJWS_4_Y6_Ka_Z3or6_Yhysh2_EE_Up8bgpump_df8a28af96_2ec9192397.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIHARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIHARU>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xa32cc2f5dca4839709141ccc4c2249905fe278ca98a6b0ec9c5f63a541476d85::tmw {
    struct TMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMW>(arg0, 6, b"TMW", b"Trump Must Win", b"Donald Trump is in his 70s, but he is still fighting for our freedom and a better life. Let's support him.We must trust him.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QAU_6_Yhh9_Nd_Tfi_SML_4_Hfw_Rd279_K_Qy_Tiuqem_G9qi2b_Js_RV_56d275a186.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMW>>(v1);
    }

    // decompiled from Move bytecode v6
}


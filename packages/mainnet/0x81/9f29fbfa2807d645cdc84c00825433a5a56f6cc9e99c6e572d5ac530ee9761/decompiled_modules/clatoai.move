module 0x819f29fbfa2807d645cdc84c00825433a5a56f6cc9e99c6e572d5ac530ee9761::clatoai {
    struct CLATOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLATOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLATOAI>(arg0, 6, b"CLATOAI", b"Clato AI", x"526573757272656374696e6720506c61746f7320707572726c6f736f706879207468726f7567682041490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_PL_Adh2_Drz7jk_Hu_Y2nq_CS_5vbzqs398qx_VNVGVTL_548fe_E_8c75242e84.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLATOAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLATOAI>>(v1);
    }

    // decompiled from Move bytecode v6
}


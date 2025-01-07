module 0x7585a24375f658a811ce5bee8c0446f873b513f6502c7d42e60885274a9629db::ccf {
    struct CCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCF>(arg0, 6, b"CCF", b"Chicken Cat Fish", x"0a24434346204f4e20245355490a20446f206974206a75737420666f722066756e2c20627574206d6179626520736f6d657468696e67207370656369616c20697320636f6d696e672e2e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zf_UAX_7_XEAM_8_Oqc_93b6eff9ac.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCF>>(v1);
    }

    // decompiled from Move bytecode v6
}


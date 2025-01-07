module 0x1c02502e000a064ac741ae82faa2479d4a1dee10e31597a071e150189f63c441::oss {
    struct OSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSS>(arg0, 6, b"OSS", b"SenSui", b"Patience is the Key son!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_DF_887_DE_06_DC_469_A_A5_A0_2_A9_CD_2_EEA_929_e18327e586.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSS>>(v1);
    }

    // decompiled from Move bytecode v6
}


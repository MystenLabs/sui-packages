module 0xb31b080cf57b71d5a068351e7d0d40c548b4bdcd5fb836f74d33161771079636::suihc {
    struct SUIHC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHC>(arg0, 6, b"SuiHC", b"Suing Huge Cock", b"Suing HUge Cock Around SUI ECO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_14_at_17_27_37_26514f04ii_872d0c83d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHC>>(v1);
    }

    // decompiled from Move bytecode v6
}


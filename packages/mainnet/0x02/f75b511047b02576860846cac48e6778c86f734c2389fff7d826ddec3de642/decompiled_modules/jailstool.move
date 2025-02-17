module 0x2f75b511047b02576860846cac48e6778c86f734c2389fff7d826ddec3de642::jailstool {
    struct JAILSTOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAILSTOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAILSTOOL>(arg0, 6, b"JAILSTOOL", b"Stool Prisondente", b"I invented Barstool Sports. Owner of #DDTG Global. A DraftKings Man. I collect meme coins as a hobby. Its volatile. Trenches arent for you. Dont do it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Axrieh_R6_Xw3adz_Hopnv_Mn7_Gcp_R_Fc_D41ddpi_TW_Mg6pump_f96974dc41.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAILSTOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAILSTOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}


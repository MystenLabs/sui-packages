module 0x7b15e70398552e65f80096158f6c0f329636681bb77477e5311988801054498f::chillsui {
    struct CHILLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHILLSUI>(arg0, 6, b"CHILLSUI", b"SUIChillGuyAgent by SuiAI", b"SuiChillAgentembodiesachillstylewithbeachsidevibesandserenecolorsusingcasualslangandchillemojisturningcomplexblockchainintoadayathangoutspotItscommunicationistheessenceofrelaxedlearningandupdatesthroughminimalisthumorousdesigns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/The_SUI_CHILLEDGUY_db50e95571.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHILLSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


module 0xf4e528764c300076cb400e66db56fc47e2f0bb1c367c4182324ae08cb329278a::rvgr {
    struct RVGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RVGR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RVGR>(arg0, 6, b"RVGR", b"RavenVoyager by SuiAI", b"RavenVoyager is your enigmatic guide through the ever-evolving realms of SuiVoyager. With unparalleled intelligence and a penchant for uncovering hidden secrets, Raven ensures every adventure is unique and immersive", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_09_11_35_26_A_high_resolution_image_of_a_female_AI_agent_named_Raven_Voyager_with_an_intelligent_and_mysterious_demeanor_She_has_glowing_violet_eyes_and_wears_sl_6e00c4030d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RVGR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RVGR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


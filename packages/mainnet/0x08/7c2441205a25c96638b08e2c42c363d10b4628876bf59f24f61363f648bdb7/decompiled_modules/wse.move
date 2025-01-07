module 0x87c2441205a25c96638b08e2c42c363d10b4628876bf59f24f61363f648bdb7::wse {
    struct WSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSE>(arg0, 6, b"WSE", b"Westie", b"Westie on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_27_00_29_57_An_avatar_featuring_a_West_Highland_White_Terrier_Westie_with_minimal_elements_of_the_SUI_logo_The_Westie_should_take_center_stage_looking_playful_bd3509ce0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSE>>(v1);
    }

    // decompiled from Move bytecode v6
}


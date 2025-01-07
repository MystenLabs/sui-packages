module 0xb8a0c173226949a556c469939b5cadfacf081f774e4367a0323c448861c1462c::blob {
    struct BLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOB>(arg0, 6, b"BLOB", b"BLOB the FISH", b"BLOB the fish is here for representing all SUI community who lives under the ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_26_13_37_43_A_blobfish_with_a_surreal_underwater_setting_The_blobfish_is_holding_or_has_the_SUI_coin_logo_prominently_displayed_on_its_body_or_near_it_blending_023538f939.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}


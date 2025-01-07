module 0x85d20164fcc13e230c799825016c3369baabfcb555e40deabc868ec5a87f05e::wansui {
    struct WANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANSUI>(arg0, 6, b"Wansui", b"Wansui Token", b"Wansui is a fair-launch platform. Each coin has no presale and no team allocation. Buy Wansui and share the revenu from our website", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4s_82i_JI_400x400_f0ccbc7eba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WANSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xbbed4b553aa8d8863a9a4a53d768f6785ea220230a20f72d8d4e4c00701c5598::kabosui {
    struct KABOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABOSUI>(arg0, 6, b"KABOSUI", b"KABOSU", b"Kabosu is the most famous dog in crypto history, and SUI must have a version also!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Skjermbilde_2024_09_16_135120_d30793ebca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


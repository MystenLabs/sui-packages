module 0xf9a7d974e7083a4d558bc8a9ed5737670c22f0d7a1645ee596262ce681a1458b::pawtato_coin_frgmnt_insight {
    struct PAWTATO_COIN_FRGMNT_INSIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_FRGMNT_INSIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_FRGMNT_INSIGHT>(arg0, 9, b"FRGMT_INSIGHT", b"Pawtato Fragment of Insight", b"This fragment holds ancient memory. When pressed to the heart, it reveals echoes of the lost civilizations of Axoma.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/fragment-of-insight.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_FRGMNT_INSIGHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_FRGMNT_INSIGHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


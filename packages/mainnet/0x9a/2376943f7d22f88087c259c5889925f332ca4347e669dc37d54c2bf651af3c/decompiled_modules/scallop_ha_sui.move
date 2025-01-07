module 0x9a2376943f7d22f88087c259c5889925f332ca4347e669dc37d54c2bf651af3c::scallop_ha_sui {
    struct SCALLOP_HA_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_HA_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_HA_SUI>(arg0, 9, b"sHaSUI", b"sHaSUI", b"Scallop interest-bearing token for haSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sfjq6igesj7aq6tgzx6wem6dl5kpdhgp6x5otojys66qoudqtbfa.arweave.net/kVMPIMSSfgh6Zs39YjPDX1TxnM_1-um5OJe9B1BwmEo")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_HA_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_HA_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


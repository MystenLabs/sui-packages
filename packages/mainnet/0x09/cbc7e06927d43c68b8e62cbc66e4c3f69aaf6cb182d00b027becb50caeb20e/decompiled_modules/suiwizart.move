module 0x9cbc7e06927d43c68b8e62cbc66e4c3f69aaf6cb182d00b027becb50caeb20e::suiwizart {
    struct SUIWIZART has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIZART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIZART>(arg0, 6, b"SuiWizArt", b"SuiWiz", b"Cloaked in the mystical aura of arcane energy, the Sorcerer SuiWiz manipulates the very essence of water, earth, fire, and air, weaving spells of wonder and enchantment with every flick of their staff.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3668_5e738ade38.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIZART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIZART>>(v1);
    }

    // decompiled from Move bytecode v6
}


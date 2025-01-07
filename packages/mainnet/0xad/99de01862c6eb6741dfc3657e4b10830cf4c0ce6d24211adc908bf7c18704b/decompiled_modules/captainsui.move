module 0xad99de01862c6eb6741dfc3657e4b10830cf4c0ce6d24211adc908bf7c18704b::captainsui {
    struct CAPTAINSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPTAINSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPTAINSUI>(arg0, 6, b"CAPTAINSUI", b"Captain Sui", b"Introducing Captain Sui ($CAPTAINSUI) The legendary pirate king of the sea! This coin embodies the spirit of adventure and treasure hunting, sailing through the Sui waters with the might of a true captain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_63_1c3f90e2ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPTAINSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPTAINSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


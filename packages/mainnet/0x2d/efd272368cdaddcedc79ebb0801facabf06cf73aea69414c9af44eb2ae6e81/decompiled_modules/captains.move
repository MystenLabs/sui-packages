module 0x2defd272368cdaddcedc79ebb0801facabf06cf73aea69414c9af44eb2ae6e81::captains {
    struct CAPTAINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPTAINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPTAINS>(arg0, 6, b"CAPTAINS", b"Captain Sui", b"Captain Sui is a hero in the SUI blockchain sea, leading his community to face challenges and opportunities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_a18938b216.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPTAINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPTAINS>>(v1);
    }

    // decompiled from Move bytecode v6
}


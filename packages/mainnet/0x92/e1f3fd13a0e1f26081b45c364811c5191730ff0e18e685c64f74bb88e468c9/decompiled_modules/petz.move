module 0x92e1f3fd13a0e1f26081b45c364811c5191730ff0e18e685c64f74bb88e468c9::petz {
    struct PETZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETZ>(arg0, 9, b"PETZ", b"SuiPets", b"A fun, community-driven token inspired by the playful energy of our furry friends. With $PETZ, each holder joins a pack of like-minded pet lovers on the Sui network, unlocking exclusive games, NFT drops, and pet-themed surprises.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50a0de8d-e328-4f77-bacf-b63e6632301d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PETZ>>(v1);
    }

    // decompiled from Move bytecode v6
}


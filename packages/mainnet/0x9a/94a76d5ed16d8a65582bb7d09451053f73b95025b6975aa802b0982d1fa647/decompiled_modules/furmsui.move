module 0x9a94a76d5ed16d8a65582bb7d09451053f73b95025b6975aa802b0982d1fa647::furmsui {
    struct FURMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURMSUI>(arg0, 6, b"FURMSUI", b"FURMULA GAME", b"FURMULA is the highest class of international racing on Solana. Their presale has been done less than a minute with 10k SOL hardcap. Has lower cap compare to other gamefi projects. $FURM just launched recently. Has moved well, 44M area. Exchange listings soon. Good branding and ticker. Higher mcap play. Be safe if going in. Links Below. Dyor. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250111_001458_157_88e8f12fff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FURMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


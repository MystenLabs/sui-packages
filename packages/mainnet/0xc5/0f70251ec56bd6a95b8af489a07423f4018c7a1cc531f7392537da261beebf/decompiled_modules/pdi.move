module 0xc50f70251ec56bd6a95b8af489a07423f4018c7a1cc531f7392537da261beebf::pdi {
    struct PDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDI>(arg0, 9, b"PDI", b"DEMORASI", b"PDI (Participation, Decentralization, Inclusivity) is a meme coin celebrating freedom, participation, and openness in the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed424f04-b6d4-4ea4-a347-b739cc4fd26c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x144455f3dc516d914e37b95a877f0a1af195088790dbb3670c0b060a792987e5::sdrag {
    struct SDRAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRAG>(arg0, 6, b"SDRAG", b"Sui Dragon", b"Introducing SuiDragon, the blazing hot new meme token taking the crypto world by storm! Inspired by the mythical and powerful dragon, SuiDragon soars into the market as the token of choice for 2024, the auspicious year of the dragon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xcd86f675b4bfbf415c094ffb231b52b880edffebf4ba0ad6d5d8119ca224eaff_sdrag_sdrag_288b2bc344.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDRAG>>(v1);
    }

    // decompiled from Move bytecode v6
}


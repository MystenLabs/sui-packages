module 0xa9cf26a0f968112dd21358645eab65e90ca420b2a3c83116fbc20c6a22743fed::fm {
    struct FM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FM>(arg0, 9, b"FM", b"Famos", b"Famos (FM) is a community-driven meme token inspired by the love and unity of its founders. As an acronym for the founders' initials, Famos represents the bond between two individuals and their vision to spread love and positivity globally.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d3a2685-aed9-4380-bf38-51653f6e2b2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FM>>(v1);
    }

    // decompiled from Move bytecode v6
}


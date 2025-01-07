module 0xd9ab867948641c6d276af9a89ac1c0f71e4071be07935dd14dc067a7a6db4dee::bitsui {
    struct BITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITSUI>(arg0, 6, b"BITSUI", b"BitSui", b"BitSui is an innovative digital currency that blends the stability and reputation of Bitcoin with the advanced technology and ultra-fast infrastructure offered by Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_41de2c5f66.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xf4a36719a3c38a0bedc6bccd77a85d70d60654daa0591734fb67e699263bbb2::kingzilla {
    struct KINGZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGZILLA>(arg0, 6, b"KINGZILLA", b"Kingzilla", b"The symbol of dominance and the King of all Kings on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/king_zilla_logo_design_070298ce98.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}


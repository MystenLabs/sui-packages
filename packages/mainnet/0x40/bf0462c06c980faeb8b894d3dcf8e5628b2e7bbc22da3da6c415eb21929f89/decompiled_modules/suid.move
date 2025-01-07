module 0x40bf0462c06c980faeb8b894d3dcf8e5628b2e7bbc22da3da6c415eb21929f89::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 6, b"SUID", b"Unicorn Dust Sui", b"Unicorn Sui Dust: Magical, shiny, pointless, and irresistibly chaotic $SUID on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/creater_1692deefbc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUID>>(v1);
    }

    // decompiled from Move bytecode v6
}


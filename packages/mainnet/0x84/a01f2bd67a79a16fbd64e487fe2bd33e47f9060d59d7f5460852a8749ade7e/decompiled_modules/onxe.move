module 0x84a01f2bd67a79a16fbd64e487fe2bd33e47f9060d59d7f5460852a8749ade7e::onxe {
    struct ONXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONXE>(arg0, 6, b"ONXE", b"ONXE ON SUI", b"The x, the one, the next to be, onxe is the key to set us free.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/672b7256710a46c600998859_logo_p_500_f8cdc7071b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONXE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONXE>>(v1);
    }

    // decompiled from Move bytecode v6
}


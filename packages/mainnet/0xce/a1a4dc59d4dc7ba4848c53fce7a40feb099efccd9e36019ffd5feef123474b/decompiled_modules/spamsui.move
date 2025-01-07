module 0xcea1a4dc59d4dc7ba4848c53fce7a40feb099efccd9e36019ffd5feef123474b::spamsui {
    struct SPAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAMSUI>(arg0, 6, b"SPAMSUI", b"spam on sui", b"spam sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K_Ee5v7_DZ_400x400_ec76cc1f59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


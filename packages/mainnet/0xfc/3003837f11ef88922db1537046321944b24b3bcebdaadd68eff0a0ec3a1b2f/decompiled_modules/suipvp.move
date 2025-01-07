module 0xfc3003837f11ef88922db1537046321944b24b3bcebdaadd68eff0a0ec3a1b2f::suipvp {
    struct SUIPVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPVP>(arg0, 6, b"SUIPVP", b"PVPonSUI", b"Come at me, bro, with your little bot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pvp_6d06be7b17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPVP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPVP>>(v1);
    }

    // decompiled from Move bytecode v6
}


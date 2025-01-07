module 0x30f717a9d7c11c943f36a9e5971fa573308407ff0ba17a8b70398eb1ce62153c::kama {
    struct KAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMA>(arg0, 6, b"KAMA", b"KAMALO HORRIS", b"kamalo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GR_Saiv_Ya_EAA_Pqyp_a3ecd374ba.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}


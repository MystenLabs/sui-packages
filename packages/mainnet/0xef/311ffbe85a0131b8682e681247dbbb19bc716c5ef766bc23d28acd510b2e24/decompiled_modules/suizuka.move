module 0xef311ffbe85a0131b8682e681247dbbb19bc716c5ef766bc23d28acd510b2e24::suizuka {
    struct SUIZUKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZUKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZUKA>(arg0, 6, b"SUIZUKA", b"Suizuka", b"Suizuka: A heart full of kindness, with a smile that brightens even the gloomiest of days $SUIZAKA for everyone! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qasgw8s0uygi7_FP_Dn_Dm_o_267f131777.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZUKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZUKA>>(v1);
    }

    // decompiled from Move bytecode v6
}


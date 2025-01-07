module 0xe48ac5d5da5627a16c1a673a6ee39c7ceac7ff303c44f3e01c1db93a5acafcbf::suiniper {
    struct SUINIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIPER>(arg0, 6, b"SUINIPER", b"Sui Sniper", b"$SUINIPER is your secret weapon in the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_77_e2380bbb29.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIPER>>(v1);
    }

    // decompiled from Move bytecode v6
}


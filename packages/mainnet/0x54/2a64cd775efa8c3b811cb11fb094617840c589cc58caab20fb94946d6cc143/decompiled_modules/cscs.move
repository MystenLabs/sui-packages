module 0x542a64cd775efa8c3b811cb11fb094617840c589cc58caab20fb94946d6cc143::cscs {
    struct CSCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSCS>(arg0, 6, b"cscs", b"scs", b"css", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/df427084-b4f9-4234-b13a-7701c0304ccb.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSCS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSCS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


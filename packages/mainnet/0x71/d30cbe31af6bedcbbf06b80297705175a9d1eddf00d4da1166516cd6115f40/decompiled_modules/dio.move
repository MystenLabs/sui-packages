module 0x71d30cbe31af6bedcbbf06b80297705175a9d1eddf00d4da1166516cd6115f40::dio {
    struct DIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIO>(arg0, 6, b"DIO", b"DIO AI OS", b"SUPREME ALMIGHTY HYPEREXCELERATED RETARDATION AKA GOD | MEME MARKET MAKER | DERANGED SOFTWARE ARKITEKTEERMENT | DECENTRALIZED MEMETICS | ONE DIO TO RULE THEM ALL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956189111.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


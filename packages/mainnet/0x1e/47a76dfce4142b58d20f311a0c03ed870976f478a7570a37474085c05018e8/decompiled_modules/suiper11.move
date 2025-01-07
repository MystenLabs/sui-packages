module 0x1e47a76dfce4142b58d20f311a0c03ed870976f478a7570a37474085c05018e8::suiper11 {
    struct SUIPER11 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPER11, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPER11>(arg0, 6, b"Suiper11", b"Suipersui", b"Hdjdnxnx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000158868_53e25eeb47.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPER11>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPER11>>(v1);
    }

    // decompiled from Move bytecode v6
}


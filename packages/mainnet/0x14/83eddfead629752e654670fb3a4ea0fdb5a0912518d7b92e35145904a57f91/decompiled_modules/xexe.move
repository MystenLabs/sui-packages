module 0x1483eddfead629752e654670fb3a4ea0fdb5a0912518d7b92e35145904a57f91::xexe {
    struct XEXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XEXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XEXE>(arg0, 6, b"XEXE", b"XEXE SUI TOKEN", b"Xexe, now shines on Ethereum with her own token, attracting crypto investors looking for the next mooncoin sensation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/untitled_1444_20240704051502_e0xtg_3_9ff80fe4ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XEXE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XEXE>>(v1);
    }

    // decompiled from Move bytecode v6
}


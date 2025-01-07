module 0xe98a3e49d93256e1e1f348d7814e9a6f9d641a48cf5158965c53bb7f75e88936::aaaeod {
    struct AAAEOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAEOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAEOD>(arg0, 6, b"AAAEOD", b"A.A.A.E.O.D", b"AAAA???SE&#E?NE??{?!?!W!!?S!??!!AA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003040_c212ecada9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAEOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAEOD>>(v1);
    }

    // decompiled from Move bytecode v6
}


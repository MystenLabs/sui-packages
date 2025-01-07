module 0x73d616f757e25d18ed5d6315d648f72bcd2a703ef5cb76ffaf1818a99f869086::grenbi {
    struct GRENBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRENBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRENBI>(arg0, 6, b"GRENBI", b"GREENBI SUI", b"GREENBI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zombie_2799591_1280_f818566b16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRENBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRENBI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x78d9c18a7d608d220ce0f98fd2541148aa8de83b318310a2e807febdcf178b36::epstein {
    struct EPSTEIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPSTEIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPSTEIN>(arg0, 6, b"EPSTEIN", b"Island Lord", b"Join the list and embark on the Lolita Express", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/epstein_4249ce9a22.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPSTEIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPSTEIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


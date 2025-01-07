module 0x21c6128ed9461c45867971e4ed82df3ff15022a23b222d67c5c011c9735edd4c::huzz {
    struct HUZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUZZ>(arg0, 6, b"HUZZ", b"the huzz", b"Oh nah not in front of the huzz dawg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005302_19d844e143.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}


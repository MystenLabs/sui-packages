module 0xc1ce57450bbfa191fbd0a2af3366789585617305221cabb6f8612e5b80cf1655::puffet {
    struct PUFFET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFET>(arg0, 6, b"PUFFET", b"PUFFER EATING CARROT", b"PUFFER FISH EATING CARROT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/puffer_312572068d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFET>>(v1);
    }

    // decompiled from Move bytecode v6
}


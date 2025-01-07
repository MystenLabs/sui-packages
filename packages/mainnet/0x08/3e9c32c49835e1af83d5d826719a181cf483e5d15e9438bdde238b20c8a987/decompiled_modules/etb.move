module 0x83e9c32c49835e1af83d5d826719a181cf483e5d15e9438bdde238b20c8a987::etb {
    struct ETB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETB>(arg0, 6, b"ETB", b"EddieTheBoss", b"Eddie the boss of SUIchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eddietheboss_0d8c8ffb02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETB>>(v1);
    }

    // decompiled from Move bytecode v6
}


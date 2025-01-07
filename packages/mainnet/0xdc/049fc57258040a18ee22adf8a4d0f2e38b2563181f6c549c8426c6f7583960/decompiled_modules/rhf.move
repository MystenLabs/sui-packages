module 0xdc049fc57258040a18ee22adf8a4d0f2e38b2563181f6c549c8426c6f7583960::rhf {
    struct RHF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHF>(arg0, 6, b"RHF", b"RipHopfun", b"Since Hope is not working, we decided to give you hope here in Move Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hopfun_ae562e4f10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHF>>(v1);
    }

    // decompiled from Move bytecode v6
}


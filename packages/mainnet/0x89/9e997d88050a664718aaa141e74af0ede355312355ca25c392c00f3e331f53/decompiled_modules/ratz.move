module 0x899e997d88050a664718aaa141e74af0ede355312355ca25c392c00f3e331f53::ratz {
    struct RATZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATZ>(arg0, 6, b"RATZ", b"Degeneratz", b"John Oliver might drool over these whiskered DEGENERATZ, whove seen Noah munch half his ark and Moses chuck a third tabletall while threatening to wipe out humanity, just for the fucks of it. They dont get stressed; they cause stress, and theyll give rabies to any entitled little cunt who tries to leech off their cheese supply. If you dare join this mischief, drop your morals, grab some cheddar, and be ready to fuck at all timescause WE RATZ ARE HAPPY RATZ.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/144_3a493aeae2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATZ>>(v1);
    }

    // decompiled from Move bytecode v6
}


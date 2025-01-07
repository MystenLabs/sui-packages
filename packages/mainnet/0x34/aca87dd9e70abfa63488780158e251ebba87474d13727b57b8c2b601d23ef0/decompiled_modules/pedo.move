module 0x34aca87dd9e70abfa63488780158e251ebba87474d13727b57b8c2b601d23ef0::pedo {
    struct PEDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEDO>(arg0, 6, b"PEDO", b"PEDO BEAR", b"PEDO BEAR ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000193733_cb8d4f44ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEDO>>(v1);
    }

    // decompiled from Move bytecode v6
}


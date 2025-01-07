module 0xda6e25cfb97e6757abca7efc8cc323ab96f036e47dca2f80c199b3c7c6f87a25::dorry {
    struct DORRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORRY>(arg0, 6, b"DORRY", b"DORRY SUIMASCOT", b"DORRY SUI MASCOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dorrylogo_f35c45604d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORRY>>(v1);
    }

    // decompiled from Move bytecode v6
}


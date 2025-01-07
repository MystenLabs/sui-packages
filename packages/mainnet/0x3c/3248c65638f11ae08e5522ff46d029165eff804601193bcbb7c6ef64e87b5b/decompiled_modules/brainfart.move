module 0x3c3248c65638f11ae08e5522ff46d029165eff804601193bcbb7c6ef64e87b5b::brainfart {
    struct BRAINFART has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAINFART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAINFART>(arg0, 6, b"BRAINFART", b"Brainfart", b"Brainfart degen ADVENTURE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046329_482e7b769b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAINFART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAINFART>>(v1);
    }

    // decompiled from Move bytecode v6
}


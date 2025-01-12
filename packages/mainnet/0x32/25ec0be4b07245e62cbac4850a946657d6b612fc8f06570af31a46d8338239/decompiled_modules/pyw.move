module 0x3225ec0be4b07245e62cbac4850a946657d6b612fc8f06570af31a46d8338239::pyw {
    struct PYW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYW>(arg0, 6, b"PYW", b"ProveYouWrong", b"this is to prove that you are wrong ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_03_114721_f3a22f05e0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PYW>>(v1);
    }

    // decompiled from Move bytecode v6
}


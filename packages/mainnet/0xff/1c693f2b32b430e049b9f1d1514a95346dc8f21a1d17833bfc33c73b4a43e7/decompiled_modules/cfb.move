module 0xff1c693f2b32b430e049b9f1d1514a95346dc8f21a1d17833bfc33c73b4a43e7::cfb {
    struct CFB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFB>(arg0, 6, b"CFB", b"Cute Fluffy Ball", b"Animals  Nature  Discovery ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_40c410f314.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CFB>>(v1);
    }

    // decompiled from Move bytecode v6
}


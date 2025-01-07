module 0x4da45256d666095df4646496124b6a77a4ce51d41986f9b087892b78c08351c2::pophanbao {
    struct POPHANBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPHANBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPHANBAO>(arg0, 6, b"POPHANBAO", b"Pophanbao", b"The Hanbao pops", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6846_8666e13bfd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPHANBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPHANBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}


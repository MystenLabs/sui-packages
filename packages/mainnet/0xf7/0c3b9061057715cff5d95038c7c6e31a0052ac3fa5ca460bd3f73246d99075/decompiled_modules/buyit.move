module 0xf70c3b9061057715cff5d95038c7c6e31a0052ac3fa5ca460bd3f73246d99075::buyit {
    struct BUYIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUYIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUYIT>(arg0, 6, b"BUYIT", b"BUY IT TOKEN", b"BUY IT TOKEN WITHOUT ANY SOCIALS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dadax_5_04791cfde4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUYIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUYIT>>(v1);
    }

    // decompiled from Move bytecode v6
}


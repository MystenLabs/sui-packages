module 0x19d4c855423ce92d5c4087b40fb578a7d5e14ada18143dd087826db70aa8c522::bube {
    struct BUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBE>(arg0, 6, b"Bube", b"Bubbles", b"https://x.com/bubbles_sui/status/1844834572913217910?s=46", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000205754_c6319772c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}


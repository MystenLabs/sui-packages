module 0xda8d67cb1ea26707e098ac5bf58df24afefc4ad487417195b82eea69c979b72::bruh {
    struct BRUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUH>(arg0, 6, b"BRUH", b"Bruh", b"Bruh on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bruh_48ee1c4343.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUH>>(v1);
    }

    // decompiled from Move bytecode v6
}


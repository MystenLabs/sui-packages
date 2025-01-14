module 0xde088256e58c6e3e3271856528d160b259913e1ef9d17157f63130e221730ea2::babo {
    struct BABO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABO>(arg0, 6, b"BABO", b"Babo Shark", b"A BABO SHARK wanna break his wonder over the deep sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024771_f3ec309823.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABO>>(v1);
    }

    // decompiled from Move bytecode v6
}


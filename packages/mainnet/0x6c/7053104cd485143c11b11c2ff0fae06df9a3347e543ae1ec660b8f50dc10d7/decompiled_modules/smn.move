module 0x6c7053104cd485143c11b11c2ff0fae06df9a3347e543ae1ec660b8f50dc10d7::smn {
    struct SMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMN>(arg0, 6, b"SMN", b"Suiman Pepe", b"Have no fear, Suiman Pepe is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_174833_14108600dc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMN>>(v1);
    }

    // decompiled from Move bytecode v6
}


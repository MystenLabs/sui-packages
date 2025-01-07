module 0x7fe18755f6af4e7a01f76ec68399fd1e3e714107ea6f0af155ea5ff1df928ac9::moomas {
    struct MOOMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOMAS>(arg0, 6, b"MOOMAS", b"Sui Moomas", b"Moomas is coming, I am the new santa's", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019714_366644a50f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}


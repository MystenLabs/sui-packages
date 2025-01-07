module 0xb84b531044f122215c68e51d3abc239381b8be84b1b65d08e2b5c31e2bc47748::sal {
    struct SAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAL>(arg0, 6, b"Sal", b"Suisal", b"A Silly Salmon Making Waves in the Sui Ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4035_150178417b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAL>>(v1);
    }

    // decompiled from Move bytecode v6
}


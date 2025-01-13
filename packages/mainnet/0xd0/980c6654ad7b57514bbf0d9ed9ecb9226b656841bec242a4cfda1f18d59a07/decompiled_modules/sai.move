module 0xd0980c6654ad7b57514bbf0d9ed9ecb9226b656841bec242a4cfda1f18d59a07::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"Spirit AI on Sui", b"SPIRIT AI :  Guiding spirits, the future of AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/THRIVE_1_b55eac9646.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAI>>(v1);
    }

    // decompiled from Move bytecode v6
}


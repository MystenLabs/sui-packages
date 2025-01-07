module 0x5f526edfaf0995bcca52181a3d6c770683846d702dba18577e5101d4f64b75b6::qvl {
    struct QVL has drop {
        dummy_field: bool,
    }

    fun init(arg0: QVL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QVL>(arg0, 6, b"QVL", b"Quantum Void Labs", b"Quantum Void Labs is analytics organization dedicated to developing open-source applications. We specialize in developing algorithms that are freely available to the public under the MIT License.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_07_24_19_dcea250efb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QVL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QVL>>(v1);
    }

    // decompiled from Move bytecode v6
}


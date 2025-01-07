module 0x343e0c0b08b268413a696c8cc93015b8351009a1430513df657bbd30eeb97fd1::suyrup {
    struct SUYRUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUYRUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUYRUP>(arg0, 6, b"Suyrup", b"Codeine Lean Sui", b"Lean is known for its relaxing and euphoric effects, combining cough syrup with soda for a unique experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdmnhjkhjk_298f07ae3b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUYRUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUYRUP>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x90adca0063e511d9b67090dafea478e3fb79e01e8d45046066ecf770f1f9efa0::eagle {
    struct EAGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EAGLE>(arg0, 6, b"Eagle", b"Elon Musk", b"The rebirth of the Eagle is like the story of a legendary bird. But what we are talking about is not the life cycle of a bird. The painful \"rebirth\" process of the Eagle is like the storms that occur in human life. Each of us who wants to develop and move", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/e58b3fc2-54d6-4e73-bc10-4e159d46a108.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EAGLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EAGLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xb67127e584d4352f3469b9695fd414891ec5ac840c038460f64892c01ef60c6a::sra {
    struct SRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRA>(arg0, 6, b"SRA", b"smart rabbit", b"Rabbit 2.0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240621_112023_2dc31bbb5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRA>>(v1);
    }

    // decompiled from Move bytecode v6
}


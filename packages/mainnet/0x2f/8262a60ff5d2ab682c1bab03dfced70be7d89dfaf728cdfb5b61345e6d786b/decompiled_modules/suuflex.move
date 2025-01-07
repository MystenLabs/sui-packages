module 0x2f8262a60ff5d2ab682c1bab03dfced70be7d89dfaf728cdfb5b61345e6d786b::suuflex {
    struct SUUFLEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUUFLEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUUFLEX>(arg0, 6, b"SUUFLEX", b"Suuflex", b"Journey of SUU to the Suuuuii ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUU_1_859d9b0982.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUUFLEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUUFLEX>>(v1);
    }

    // decompiled from Move bytecode v6
}


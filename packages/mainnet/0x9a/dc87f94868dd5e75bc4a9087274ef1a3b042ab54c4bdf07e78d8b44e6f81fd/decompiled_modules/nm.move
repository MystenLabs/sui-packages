module 0x9adc87f94868dd5e75bc4a9087274ef1a3b042ab54c4bdf07e78d8b44e6f81fd::nm {
    struct NM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NM>(arg0, 6, b"NM", b"Narwhal Moverz", b"We like to Move it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kfn_Y_Qu_S2_400x400_4c9cc38af9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NM>>(v1);
    }

    // decompiled from Move bytecode v6
}


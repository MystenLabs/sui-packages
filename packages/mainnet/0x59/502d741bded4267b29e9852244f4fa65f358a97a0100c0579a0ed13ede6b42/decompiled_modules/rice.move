module 0x59502d741bded4267b29e9852244f4fa65f358a97a0100c0579a0ed13ede6b42::rice {
    struct RICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICE>(arg0, 6, b"RICE", b"Rice", b"I can cure her", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000114393_de47d3cc41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICE>>(v1);
    }

    // decompiled from Move bytecode v6
}


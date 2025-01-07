module 0x93c3d5c59a84dd8ce508de8f68d048c926be937f75ec6608a34f88eca76dcf8a::frolik {
    struct FROLIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROLIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROLIK>(arg0, 6, b"FROLIK", b"Frolik", b"Frolik the crowned frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021925_9e94dcf2f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROLIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROLIK>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xdd0d9301509407b32274bfa53953f343cbb5be671920fd705c5aa86b6f658e8::dsf {
    struct DSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSF>(arg0, 6, b"DSF", b"Dog Search Fridge", b"An original Mem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dogsearch_d9af37dc00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSF>>(v1);
    }

    // decompiled from Move bytecode v6
}


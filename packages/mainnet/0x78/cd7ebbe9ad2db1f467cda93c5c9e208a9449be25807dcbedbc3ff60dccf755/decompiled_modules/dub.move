module 0x78cd7ebbe9ad2db1f467cda93c5c9e208a9449be25807dcbedbc3ff60dccf755::dub {
    struct DUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUB>(arg0, 6, b"DUB", b"dr_dick's dub shack", b"version, dub, remixes, 10 inches, 12 inches and more...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dub_shack_logo_1400b_c5522bb265.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUB>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xb87318d790779d229557bf259666bb906f9c30243a1edb33f38e64a5bb090484::keboso {
    struct KEBOSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEBOSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEBOSO>(arg0, 6, b"KEBOSO", b"Keboxo", b"The craziest monkey of SUI Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/keboso_298b404f96.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEBOSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEBOSO>>(v1);
    }

    // decompiled from Move bytecode v6
}


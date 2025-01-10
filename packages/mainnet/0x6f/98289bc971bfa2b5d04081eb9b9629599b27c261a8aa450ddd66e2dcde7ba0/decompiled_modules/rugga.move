module 0x6f98289bc971bfa2b5d04081eb9b9629599b27c261a8aa450ddd66e2dcde7ba0::rugga {
    struct RUGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGGA>(arg0, 6, b"RUGGA", b"The rugcoon", b"get rugged or die trying", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250111_004719_942_bea314d427.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}


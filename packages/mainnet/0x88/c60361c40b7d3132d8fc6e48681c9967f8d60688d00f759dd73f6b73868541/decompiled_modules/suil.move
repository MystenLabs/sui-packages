module 0x88c60361c40b7d3132d8fc6e48681c9967f8d60688d00f759dd73f6b73868541::suil {
    struct SUIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIL>(arg0, 6, b"SUIL", b"SUIte Life", b"Life is SUIte", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/SUITE_c5ee895a20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIL>>(v1);
    }

    // decompiled from Move bytecode v6
}


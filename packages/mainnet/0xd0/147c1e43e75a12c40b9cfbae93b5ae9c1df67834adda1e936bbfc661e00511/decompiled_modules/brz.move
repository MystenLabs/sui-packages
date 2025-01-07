module 0xd0147c1e43e75a12c40b9cfbae93b5ae9c1df67834adda1e936bbfc661e00511::brz {
    struct BRZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRZ>(arg0, 6, b"BRZ", b"borz", b"kavkazskiy volk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/borz_72c96f902d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRZ>>(v1);
    }

    // decompiled from Move bytecode v6
}


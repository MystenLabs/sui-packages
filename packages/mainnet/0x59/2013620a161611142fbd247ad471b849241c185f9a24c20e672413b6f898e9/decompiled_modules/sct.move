module 0x592013620a161611142fbd247ad471b849241c185f9a24c20e672413b6f898e9::sct {
    struct SCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCT>(arg0, 6, b"SCT", b"Sui Cat", b"First Cat On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUICATSUI_8320b73188.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCT>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x87ddfc8f06072fa0a4d25b0645de7bdfb54d42c0188764a704c452d3d2335aee::pfs {
    struct PFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PFS>(arg0, 6, b"PFS", b"Pop Fist Sui", b"Pop Fist On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PFS_69f4b22417.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PFS>>(v1);
    }

    // decompiled from Move bytecode v6
}


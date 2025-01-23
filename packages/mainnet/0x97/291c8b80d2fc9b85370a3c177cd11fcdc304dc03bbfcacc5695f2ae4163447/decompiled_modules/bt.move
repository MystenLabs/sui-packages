module 0x97291c8b80d2fc9b85370a3c177cd11fcdc304dc03bbfcacc5695f2ae4163447::bt {
    struct BT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BT>(arg0, 6, b"BT", b"BabyTrump", x"426162795472756d70546f6b656e0a546865204f726967696e616c2042616279205472756d7020546f6b656e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032229_7a198fa73d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BT>>(v1);
    }

    // decompiled from Move bytecode v6
}


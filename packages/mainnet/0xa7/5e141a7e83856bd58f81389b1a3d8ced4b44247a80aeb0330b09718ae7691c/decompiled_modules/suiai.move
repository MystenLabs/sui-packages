module 0xa75e141a7e83856bd58f81389b1a3d8ced4b44247a80aeb0330b09718ae7691c::suiai {
    struct SUIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAI>(arg0, 6, b"SUIAI", b"Sui AI", b"Sui trading platform launched on movepump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5716_92f1a32062.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}


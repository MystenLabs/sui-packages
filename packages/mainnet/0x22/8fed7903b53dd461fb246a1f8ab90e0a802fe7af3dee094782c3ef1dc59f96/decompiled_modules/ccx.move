module 0x228fed7903b53dd461fb246a1f8ab90e0a802fe7af3dee094782c3ef1dc59f96::ccx {
    struct CCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCX>(arg0, 9, b"CCX", b"ccx", b"fsdfads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCX>>(v1);
    }

    // decompiled from Move bytecode v6
}


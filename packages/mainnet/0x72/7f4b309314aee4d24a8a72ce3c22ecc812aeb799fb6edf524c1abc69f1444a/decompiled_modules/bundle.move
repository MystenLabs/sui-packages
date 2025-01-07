module 0x727f4b309314aee4d24a8a72ce3c22ecc812aeb799fb6edf524c1abc69f1444a::bundle {
    struct BUNDLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNDLE>(arg0, 6, b"Bundle", b"BundleReady", b"Bundle is testing by https://t.me/DefiBitch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11_1_39c241f11e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNDLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNDLE>>(v1);
    }

    // decompiled from Move bytecode v6
}


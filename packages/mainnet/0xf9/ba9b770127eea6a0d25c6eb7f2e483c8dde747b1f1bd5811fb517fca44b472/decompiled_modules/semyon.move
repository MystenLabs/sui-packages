module 0xf9ba9b770127eea6a0d25c6eb7f2e483c8dde747b1f1bd5811fb517fca44b472::semyon {
    struct SEMYON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEMYON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEMYON>(arg0, 6, b"SEMYON", b"SEMYON TOKEN", b"SEMYON Token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Semyon_3129c528ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEMYON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEMYON>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xe96ebc9d341f1fc07b6bf85e61aa1e25c5f72f627e5f5e1eceb6a92d8933c125::scd {
    struct SCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCD>(arg0, 6, b"SCD", b"Suicide", b"This will be the biggest meme on SUI chain. If youll miss youll want to suicide", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_66_c6f6e05008.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCD>>(v1);
    }

    // decompiled from Move bytecode v6
}


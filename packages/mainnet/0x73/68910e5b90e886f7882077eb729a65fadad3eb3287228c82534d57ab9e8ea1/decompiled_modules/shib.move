module 0x7368910e5b90e886f7882077eb729a65fadad3eb3287228c82534d57ab9e8ea1::shib {
    struct SHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIB>(arg0, 6, b"SHIB", b"Shiba Inu", b"S", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/823c1601-2800-4871-8fa6-b59b9162d14e.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x1b42b536c0dd6501a5e35a8ab832d96ba634c052b8a379d96aa551498b856b6d::wls {
    struct WLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLS>(arg0, 6, b"WLS", b"World Liberty SUI", b"World Liberty but backed by SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WLS_c230c12fa7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLS>>(v1);
    }

    // decompiled from Move bytecode v6
}


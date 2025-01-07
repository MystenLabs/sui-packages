module 0x67a6442fb5eb3e97dc4c0cdf69aa0d73ff669b3e03cd2887fd2e6071cc90ad58::soral {
    struct SORAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORAL>(arg0, 6, b"SORAL", b"Alain Soral", b"Best Soral on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/soral_3fa8285d1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SORAL>>(v1);
    }

    // decompiled from Move bytecode v6
}


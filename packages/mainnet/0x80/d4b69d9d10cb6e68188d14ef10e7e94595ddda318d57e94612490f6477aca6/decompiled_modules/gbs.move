module 0x80d4b69d9d10cb6e68188d14ef10e7e94595ddda318d57e94612490f6477aca6::gbs {
    struct GBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBS>(arg0, 6, b"GBS", b"GoodBoy on SUI", b"ust a good $boy on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H74_D_Eqfu_400x400_1e2b1f8fba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBS>>(v1);
    }

    // decompiled from Move bytecode v6
}


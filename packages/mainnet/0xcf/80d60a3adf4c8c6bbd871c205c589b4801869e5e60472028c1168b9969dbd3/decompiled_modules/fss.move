module 0xcf80d60a3adf4c8c6bbd871c205c589b4801869e5e60472028c1168b9969dbd3::fss {
    struct FSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSS>(arg0, 6, b"FSS", b"FrogSpider on Sui", b"Frogsiper on sui, PUMP IT MOON!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/16e43d7f_cc36_4e4f_88af_aeff6ead7787_bc356f7683.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSS>>(v1);
    }

    // decompiled from Move bytecode v6
}


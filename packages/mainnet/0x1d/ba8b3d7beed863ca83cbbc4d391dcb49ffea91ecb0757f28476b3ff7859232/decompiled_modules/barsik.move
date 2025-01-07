module 0x1dba8b3d7beed863ca83cbbc4d391dcb49ffea91ecb0757f28476b3ff7859232::barsik {
    struct BARSIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARSIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARSIK>(arg0, 6, b"BARSIK", x"48617362756c6c61e280997320436174", x"496e2061206d656d6f7279206f662068617362756c6c61e28099732063757465206361742042415253494b2e0a524950", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731859954706.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARSIK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARSIK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


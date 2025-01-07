module 0xfd0286482ddf380c0be6d2aeb465949689beb60faa2e4a4d656aa5a4c8f09931::suinest {
    struct SUINEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEST>(arg0, 6, b"Suinest", b"Suinest on Sui", b"follow me X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fkm1_Eig_XEB_0q7zv_9bb1f7a495.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEST>>(v1);
    }

    // decompiled from Move bytecode v6
}


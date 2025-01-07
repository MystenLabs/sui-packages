module 0x57db4e00891335c94e42f5a68e22f8ad72e1f907456a054efabca8ffd3daf83d::lami {
    struct LAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMI>(arg0, 6, b"LAMI", b"LamitheKitty", b"Lami is the mischievous cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ad1_M_Nz2y_400x400_efdf2c90e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}


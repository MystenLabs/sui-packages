module 0xf4027e1f9bb1364ba2b06ccc295905b7262b877cca86966946e36d6066581cce::alone {
    struct ALONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALONE>(arg0, 4, b"ALONE", b"ALONE", b"a private ALONE for sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://y.qq.com/music/photo_new/T002R300x300M000003vlbmf2UucSo_1.jpg?max_age=2592000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALONE>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ALONE>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ALONE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ALONE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


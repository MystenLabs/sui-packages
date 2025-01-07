module 0xb5e6c4b9a0ff39499876809c7eb77be935a2f634cc7f7e39e0607edad3feaef7::supreme {
    struct SUPREME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPREME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPREME>(arg0, 9, b"SUPREME", b"Supreme", b"The Supreme of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wallpaperboat.com/wp-content/uploads/2019/06/supreme-box-logo-21.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUPREME>(&mut v2, 280000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPREME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPREME>>(v1);
    }

    // decompiled from Move bytecode v6
}


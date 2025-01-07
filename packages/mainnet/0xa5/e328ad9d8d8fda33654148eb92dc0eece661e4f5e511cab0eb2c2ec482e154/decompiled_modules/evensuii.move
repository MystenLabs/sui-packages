module 0xa5e328ad9d8d8fda33654148eb92dc0eece661e4f5e511cab0eb2c2ec482e154::evensuii {
    struct EVENSUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVENSUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVENSUII>(arg0, 6, b"EVENSUII", b"EVEN", x"697320612066756e206d656d6520696e737069726564206279200a406576616e776562330a2c20436f2d666f756e64657220262043454f206f66204d797374656e204c6162732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_200351971_839f891d33.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVENSUII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVENSUII>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x7a7bb59f22da79e478e972cb410f2ce88310210802a44fd013589bf1baa80a40::morayturbo {
    struct MORAYTURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORAYTURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORAYTURBO>(arg0, 6, b"MorayTurbo", b"MORAY TURBOS", x"535549204d4f524159204f4e20545552424f530a4d4f524159205355492069732061206d656d6520746f6b656e206f6e207468652053756920626c6f636b636861696e20696e7370697265642062792074686520756e69717565206d6f7261792065656c73206f6620746865207365612e205769746820612066756e20616e64206361707469766174696e67207468656d652c204d4f52415920535549206f6666657273207a65726f20746178206f6e20616c6c207472616e73616374696f6e732c20616c6c6f77696e6720686f6c6465727320746f20667265656c7920747261646520776974686f757420666565732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731177915735.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORAYTURBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORAYTURBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


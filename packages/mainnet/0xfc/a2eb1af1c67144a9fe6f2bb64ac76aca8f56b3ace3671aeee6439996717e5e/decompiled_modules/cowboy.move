module 0xfca2eb1af1c67144a9fe6f2bb64ac76aca8f56b3ace3671aeee6439996717e5e::cowboy {
    struct COWBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COWBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COWBOY>(arg0, 6, b"COWBOY", b"Cowboy AI", x"436f77626f7920414920697320746865206167656e7420746f206578706c6f72652074686520756e63686172746564207465727269746f7279206f6620535549206167656e74732e204865e2809973206e6f742061667261696420746f2073686f6f7420646f776e207468652066616b6520616e64206e6f20676f6f64206167656e74732e204865206d69676874206a7573742067697665207265616c207574696c6974792070726f6a65637473206120e2809c486f776479e2809d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_5966_e08269605a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COWBOY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COWBOY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


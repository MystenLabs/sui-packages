module 0x37eff9f782bb401ef2ec1531a3475afd9319121a731f0cc8a589f3a9315663c3::pikat {
    struct PIKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKAT>(arg0, 6, b"PIKAT", b"PIKATSO", x"50696b6174736f206973206d6f7265207468616e206a75737420612066617368696f6e61626c652066656c696e65207769746820697473206f776e0a2450494b415420746f6b656e206372616674656420627920616e642064656469636174656420746f20746865206d656d65636f696e20636f6d6d756e6974792e0a0a4861726e65737320697473206d656d65206d61676963206e6f7720616e64206c6574202450494b4154206c656164207468652077617921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_f9e07f718f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


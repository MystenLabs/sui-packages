module 0x55f1337b4e6279ee7ec4ee5b4079bdb7b65ea426445ee45b838b567530bb350d::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"ELON DOGE", x"496e20323032352c2074686520446f676520456c6f6e6d75736b206d656d65206973207468726976696e672c20657370656369616c6c7920776974682074686520656d657267656e6365206f6620766172696174696f6e73206c696b6520e2809c53776f6c6520446f676520616e6420436865656d73e2809d2c2077686963682068756d6f726f75736c7920636f6d706172657320746865207061737420616e642070726573656e742e20456c6f6e6d75736b2077696c6c20707573682074686520707269636520746f2024312c2061747472616374696e672074686520617474656e74696f6e206f6620746865206d656d652d68756e74696e672063727970746f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/5ee1846d-e298-4a3f-a249-e7a8d7fe8a07.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x9c76bd262f2b53758849ac072713e492100da4dbeb7e4afc3b29e65c32347d1a::polby {
    struct POLBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLBY>(arg0, 6, b"POLBY", b"Sui Polby", x"48692049276d20504f4c42590a49276d2074686520636f6c646573742c206368696c6c6573742c20616e642066756e6e69657374206265617220696e2074686520656e746972652053756972637469632e2057656c636f6d6520746f206d7920776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033470_d6dd66e42c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLBY>>(v1);
    }

    // decompiled from Move bytecode v6
}


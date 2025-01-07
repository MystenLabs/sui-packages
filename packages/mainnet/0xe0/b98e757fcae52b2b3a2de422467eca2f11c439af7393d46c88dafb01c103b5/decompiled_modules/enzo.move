module 0xe0b98e757fcae52b2b3a2de422467eca2f11c439af7393d46c88dafb01c103b5::enzo {
    struct ENZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENZO>(arg0, 6, b"Enzo", b"Enzo Coin", x"496e73706972656420627920746865206c617465737420666f6f7462616c6c206e6f76656c2c20456e7a6f20436f696e2063656c656272617465732074686520626f6c646e657373206f6620456e7a6f2c2077686f206c656674207468652062656175746966756c2056616c656e74696e6120746f206578706c6f7265206e657720616476656e74757265732e205769746820456e7a6f20436f696e2c20796f752063616e206a6f696e20746869732073746f72792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730520966483.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENZO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENZO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


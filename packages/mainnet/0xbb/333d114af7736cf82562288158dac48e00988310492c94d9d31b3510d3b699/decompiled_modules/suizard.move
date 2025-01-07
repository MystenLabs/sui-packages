module 0xbb333d114af7736cf82562288158dac48e00988310492c94d9d31b3510d3b699::suizard {
    struct SUIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZARD>(arg0, 6, b"SUIZARD", b"SUIZARD TWINS", b"Cast with me Bro ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h0bdq_H_Rx_400x400_b9d2dda70a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}


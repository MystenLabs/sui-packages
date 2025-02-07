module 0xb4e0d17a18483669fc286073bce9429ef2a57f5bf80326c685ef99f1f34020a4::est22 {
    struct EST22 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST22, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST22>(arg0, 6, b"EST22", b"teskldf", b"sdfas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1738927993032-upload.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST22>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST22>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


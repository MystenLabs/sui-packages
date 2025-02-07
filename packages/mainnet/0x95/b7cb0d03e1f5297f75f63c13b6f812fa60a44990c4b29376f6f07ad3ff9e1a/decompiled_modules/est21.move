module 0x95b7cb0d03e1f5297f75f63c13b6f812fa60a44990c4b29376f6f07ad3ff9e1a::est21 {
    struct EST21 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST21, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST21>(arg0, 6, b"EST21", b"teskldf", b"sdfas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1738927993032-upload.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST21>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST21>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


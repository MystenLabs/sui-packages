module 0xa36662855ba77723af027de640a66891d195adcc44d81b31369c59eaad7124bf::vladk {
    struct VLADK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLADK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VLADK>(arg0, 6, b"VLADK", b"GG CAT VLADK", b"When you queue up for one last ranked game before bed... and it's a defeat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/af6bc40ad25389c74d0ea0afcaf6068d_6302ec4f71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLADK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VLADK>>(v1);
    }

    // decompiled from Move bytecode v6
}


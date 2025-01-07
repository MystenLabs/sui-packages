module 0x703227f34a4b1e434b1465dc78fe6a095d38ebbfed42602d66fea5ae7bbc1ebc::bchip {
    struct BCHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCHIP>(arg0, 6, b"BCHIP", b"BLUE CHIP SUI", b"BLUE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7132_40b41f33c0.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}


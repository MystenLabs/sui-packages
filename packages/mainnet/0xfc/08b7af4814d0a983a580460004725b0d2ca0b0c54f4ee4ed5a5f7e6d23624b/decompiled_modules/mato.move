module 0xfc08b7af4814d0a983a580460004725b0d2ca0b0c54f4ee4ed5a5f7e6d23624b::mato {
    struct MATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATO>(arg0, 6, b"MATO", b"SUI-MATO", b"SUI-MATO - TO-MATO. We are here to make some - MATO ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1172_e388559295.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATO>>(v1);
    }

    // decompiled from Move bytecode v6
}


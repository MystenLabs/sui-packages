module 0xfbb7df7237d86084282f26f005a7b699e0bddf31700719aaffaee0bbd2c9ab1a::notgay {
    struct NOTGAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTGAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTGAY>(arg0, 6, b"NOTGAY", b"U SELL U GAY", b"diamond hands 4ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F7ni_XL_0_WIAA_Xl6l_be2bf30d92.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTGAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTGAY>>(v1);
    }

    // decompiled from Move bytecode v6
}


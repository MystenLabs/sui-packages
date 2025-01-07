module 0xea9cd399cf479ce0ca92ccbd17e9845f1fdaaff8ab0a8f3fdf31364f0f8575c6::sogma {
    struct SOGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGMA>(arg0, 6, b"SOGMA", b"SOGMA ON SUI", b"$SOGMA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_16_12_02_30_88e91f4264.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}


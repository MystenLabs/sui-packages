module 0x60bcf97e531a4664c294bf128e74186f02abcad18aab01162af63be76fd8a641::daddy {
    struct DADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADDY>(arg0, 6, b"DADDY", b"DADDY TATE", b"CALL HIM DADDY IS OFFICIAL ON SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_10_14_160308210_2dca0cfc9e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADDY>>(v1);
    }

    // decompiled from Move bytecode v6
}


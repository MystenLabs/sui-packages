module 0xa3c0572ad790ed379965e2d6169a5640a6c9e9bae18943406cc896c549e82eb6::ftc {
    struct FTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTC>(arg0, 6, b"FTC", b"chicken Trump SUI", b"Hello America", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_27_23_23_01_27f455fe00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTC>>(v1);
    }

    // decompiled from Move bytecode v6
}


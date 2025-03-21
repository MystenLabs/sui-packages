module 0x522d55ddfeedf4469f6e2e9fe2cf083e7aa12efcd5b90cf7bca954c99f16c4b5::adeniyi {
    struct ADENIYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENIYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADENIYI>(arg0, 6, b"Adeniyi", b"retarded adeniyi", b"Iam retarded adeniyi I'll support sui szn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023402_ad1f512e3f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADENIYI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADENIYI>>(v1);
    }

    // decompiled from Move bytecode v6
}


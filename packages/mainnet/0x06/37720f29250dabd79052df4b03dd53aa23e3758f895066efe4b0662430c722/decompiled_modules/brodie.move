module 0x637720f29250dabd79052df4b03dd53aa23e3758f895066efe4b0662430c722::brodie {
    struct BRODIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRODIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRODIE>(arg0, 6, b"BRODIE", b"Brodie", x"596f7572206269672062726f7468657220626972646965206f6e205355492e0a536572696f75736c7920666c79696e6720776974682074686520636861727420686967686572207468616e206576657220696d6167696e65642c2062726f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_23_13_32_68e192c800.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRODIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRODIE>>(v1);
    }

    // decompiled from Move bytecode v6
}


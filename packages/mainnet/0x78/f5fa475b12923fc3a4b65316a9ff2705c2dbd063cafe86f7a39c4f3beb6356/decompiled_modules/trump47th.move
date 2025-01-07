module 0x78f5fa475b12923fc3a4b65316a9ff2705c2dbd063cafe86f7a39c4f3beb6356::trump47th {
    struct TRUMP47TH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP47TH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP47TH>(arg0, 6, b"Trump47th", b"I WANT TRUMP", b"The 47th President of the United States of America.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/istockphoto_120748989_1024x1024_copia_8b6f054534.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP47TH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP47TH>>(v1);
    }

    // decompiled from Move bytecode v6
}


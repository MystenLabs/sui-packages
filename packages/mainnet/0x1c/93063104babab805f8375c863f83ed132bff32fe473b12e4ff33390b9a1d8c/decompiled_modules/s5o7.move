module 0x1c93063104babab805f8375c863f83ed132bff32fe473b12e4ff33390b9a1d8c::s5o7 {
    struct S5O7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S5O7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S5O7>(arg0, 9, b"S5O7", b"tdy7uj56", b"sryu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/89942ef5d181c2fe76f14faf47f825b6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S5O7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S5O7>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


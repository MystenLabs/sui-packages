module 0xa05dad7ff2c12c4db6e85bc0002d04d484d49151e9d5c3f47971f94cbbbfec42::cats {
    struct CATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATS>(arg0, 9, b"CATS", b"cat in the clouds", b"The cats in the Lost Empire cannot give up surviving in harsh environments. One day, we will meet in the clouds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/479423043ff76162812845661a6750cablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


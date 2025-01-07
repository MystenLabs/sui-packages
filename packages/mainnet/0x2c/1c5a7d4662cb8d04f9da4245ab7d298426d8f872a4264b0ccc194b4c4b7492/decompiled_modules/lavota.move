module 0x2c1c5a7d4662cb8d04f9da4245ab7d298426d8f872a4264b0ccc194b4c4b7492::lavota {
    struct LAVOTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAVOTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAVOTA>(arg0, 9, b"LAVOTA", b"Suilavota", b"Killer kola", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/49aab8e19607bcc7682c0f780e62ecfablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAVOTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAVOTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


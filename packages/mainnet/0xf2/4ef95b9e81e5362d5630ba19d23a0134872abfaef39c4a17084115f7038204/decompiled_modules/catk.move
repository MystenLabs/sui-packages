module 0xf24ef95b9e81e5362d5630ba19d23a0134872abfaef39c4a17084115f7038204::catk {
    struct CATK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATK>(arg0, 9, b"Catk", b"7K Cat", b"My Meme in 7k", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9b2f13727b89f706ac6e3676bdf371e1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


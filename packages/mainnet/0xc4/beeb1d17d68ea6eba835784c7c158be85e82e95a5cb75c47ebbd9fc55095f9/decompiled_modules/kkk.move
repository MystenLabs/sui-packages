module 0xc4beeb1d17d68ea6eba835784c7c158be85e82e95a5cb75c47ebbd9fc55095f9::kkk {
    struct KKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKK>(arg0, 9, b"KKK", b"KrazyKillerKlown", b"Bout to get real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0228916dffd75f536fdec905d359cdfcblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


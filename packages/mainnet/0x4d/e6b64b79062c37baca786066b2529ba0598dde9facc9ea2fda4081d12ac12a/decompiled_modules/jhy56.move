module 0x4de6b64b79062c37baca786066b2529ba0598dde9facc9ea2fda4081d12ac12a::jhy56 {
    struct JHY56 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHY56, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHY56>(arg0, 9, b"JHY56", b"kyu", b"k78", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/81d4d6c03dbcd4b7ad23b18ce76d2fd3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JHY56>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JHY56>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


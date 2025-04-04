module 0xb459e82fd78b6951aa6d7e0456b5b1e38803020f015acbe1a05d62063ac903d0::icu {
    struct ICU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICU>(arg0, 9, b"ICU", b"Iseeyou coin", b"I C U", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ab003cd426aeb045471d74ce4cb67e32blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ICU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


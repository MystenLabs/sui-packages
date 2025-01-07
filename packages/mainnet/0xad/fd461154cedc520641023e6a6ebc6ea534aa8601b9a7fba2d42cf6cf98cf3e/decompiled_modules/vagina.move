module 0xadfd461154cedc520641023e6a6ebc6ea534aa8601b9a7fba2d42cf6cf98cf3e::vagina {
    struct VAGINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAGINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAGINA>(arg0, 9, b"VAGINA", b"VAGINAFART", b"make 1000x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://thumbs.dreamstime.com/b/beauty-vagina-concept-abstract-logo-sign-symbol-mark-isolated-white-background-beauty-vagina-concept-abstract-logo-sign-136841590.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VAGINA>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAGINA>>(v2, @0xf77deb5327ad4d5c260ddc86b579c8c5ad50a28e619cc1cd4cb26197eb7060ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAGINA>>(v1);
    }

    // decompiled from Move bytecode v6
}


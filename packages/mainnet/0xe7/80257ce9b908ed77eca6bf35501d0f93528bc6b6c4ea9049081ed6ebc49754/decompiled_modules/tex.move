module 0xe780257ce9b908ed77eca6bf35501d0f93528bc6b6c4ea9049081ed6ebc49754::tex {
    struct TEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEX>(arg0, 9, b"TEX", b"Texas", b"Texas Rangers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8cffc172c3cc81fd5badefd8f3ce48f3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


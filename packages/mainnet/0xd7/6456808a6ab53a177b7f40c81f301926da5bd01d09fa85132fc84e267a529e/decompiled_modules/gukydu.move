module 0xd76456808a6ab53a177b7f40c81f301926da5bd01d09fa85132fc84e267a529e::gukydu {
    struct GUKYDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUKYDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUKYDU>(arg0, 9, b"GUKYDU", b"duo", b"egduklyru", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/032f33a25c87a48965152411fc8b55ceblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUKYDU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUKYDU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


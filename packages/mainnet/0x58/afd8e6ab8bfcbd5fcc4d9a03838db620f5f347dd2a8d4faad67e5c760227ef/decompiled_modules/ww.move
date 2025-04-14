module 0x58afd8e6ab8bfcbd5fcc4d9a03838db620f5f347dd2a8d4faad67e5c760227ef::ww {
    struct WW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WW>(arg0, 9, b"Ww", b"sui sss", b"11", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/eff766d7b211bde8858f9579d4a8e4edblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


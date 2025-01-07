module 0xe3c0cb6d28826754d4f48d1a061bb21c74cfd9b33fcb3aec4cd7ddab60f48551::nkwmsn {
    struct NKWMSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKWMSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKWMSN>(arg0, 9, b"NKWMSN", b"hsjsj", b"bdjsna", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/281fd541-81fd-405d-a9bd-2e8bfe3cde73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKWMSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NKWMSN>>(v1);
    }

    // decompiled from Move bytecode v6
}


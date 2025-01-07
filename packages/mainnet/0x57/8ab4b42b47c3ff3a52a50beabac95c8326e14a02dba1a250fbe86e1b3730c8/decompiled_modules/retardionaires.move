module 0x578ab4b42b47c3ff3a52a50beabac95c8326e14a02dba1a250fbe86e1b3730c8::retardionaires {
    struct RETARDIONAIRES has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDIONAIRES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDIONAIRES>(arg0, 6, b"Retardionaires", b"Retardionaire", x"524554415244494f4e4149524545454545454545454545454545454545206f6e205355490a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x35bdda567633e091fe376c4299146c541ebb8fd9b8def1fc2d1cc92060a7389a_mitch_mitch_71d6131314.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDIONAIRES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARDIONAIRES>>(v1);
    }

    // decompiled from Move bytecode v6
}


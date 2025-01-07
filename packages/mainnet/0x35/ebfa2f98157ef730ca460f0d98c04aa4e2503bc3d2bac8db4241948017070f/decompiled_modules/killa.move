module 0x35ebfa2f98157ef730ca460f0d98c04aa4e2503bc3d2bac8db4241948017070f::killa {
    struct KILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLA>(arg0, 6, b"KILLA", b"Killa Club Inc.", x"48756e74657227732c20756e6974652e2057656c636f6d6520746f20746865206e657720636c7562206f6e200a405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xv2rrf0y_400x400_2f7182d0f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}


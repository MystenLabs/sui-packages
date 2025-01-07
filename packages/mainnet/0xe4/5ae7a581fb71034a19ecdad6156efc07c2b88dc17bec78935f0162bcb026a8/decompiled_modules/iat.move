module 0xe45ae7a581fb71034a19ecdad6156efc07c2b88dc17bec78935f0162bcb026a8::iat {
    struct IAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAT>(arg0, 6, b"IAT", b"Sui.Ai", b"innovation and the future with artificial intelligence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733881881133.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


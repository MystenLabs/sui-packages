module 0x3d451ea74321af87b0ac01d870635ad75f7b1ff09e809214543344f5e156a77e::sape {
    struct SAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPE>(arg0, 9, b"SaPE", b"Suiape", b"Sape", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/527b115fa41192219fb7c8dd2ccb28f9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x1298ee9e36adbd81b3ed7f4c0bfcdb70aa90f4c5398df8788dccd0849481cb1e::snut {
    struct SNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUT>(arg0, 9, b"SNUT", b"Seanut Arc on Sui", b"Seanut Arc on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/66d0f2ec6e07bac424f20f4b1063856ablob")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNUT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}


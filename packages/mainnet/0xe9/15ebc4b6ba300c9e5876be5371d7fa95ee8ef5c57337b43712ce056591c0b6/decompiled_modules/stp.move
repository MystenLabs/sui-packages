module 0xe915ebc4b6ba300c9e5876be5371d7fa95ee8ef5c57337b43712ce056591c0b6::stp {
    struct STP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STP>(arg0, 9, b"STP", b"SuiPepe", b"SuiPepe is a great memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/db2c2fdaf3fd10c6b9684238e9b85f44blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


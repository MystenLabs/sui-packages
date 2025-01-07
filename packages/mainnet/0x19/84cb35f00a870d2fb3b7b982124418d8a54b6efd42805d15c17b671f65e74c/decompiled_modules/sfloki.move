module 0x1984cb35f00a870d2fb3b7b982124418d8a54b6efd42805d15c17b671f65e74c::sfloki {
    struct SFLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLOKI>(arg0, 6, b"SFLOKI", b"Sui Floki", x"436f6d6d756e6974792c205574696c6974792c20436861726974792e2024464c4f4b492068617320697420616c6c2e0a0a4f6e2061206d697373696f6e20746f206265636f6d652074686520776f726c642773206d6f7374206b6e6f776e20616e6420757365642063727970746f63757272656e63792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_CJDO_Th_O_400x400_65c752c825.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFLOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFLOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}


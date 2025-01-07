module 0x2b90d7352a0713979ccac438203d0cbccf6f25ade367072efc4fb047d15b4ef1::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"Sentient ai ", b"Ai agent launchpad  with daily volume indicator with buy and sell signals ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000055797_02ad6c5bad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


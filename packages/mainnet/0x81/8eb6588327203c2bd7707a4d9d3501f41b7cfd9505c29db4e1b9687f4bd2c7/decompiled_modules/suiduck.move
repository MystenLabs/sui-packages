module 0x818eb6588327203c2bd7707a4d9d3501f41b7cfd9505c29db4e1b9687f4bd2c7::suiduck {
    struct SUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUCK>(arg0, 6, b"SUIDUCK", b"Sui Duck", b"Who is Sui duck? Born from a top-secret laboratory where mad scientists mixed blueberries with rubber ducks, it paddles through the blockchain, causing a splash. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730981076996.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


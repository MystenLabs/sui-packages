module 0x24976cae2c0079045f606da64d444ea7e2a6fbce50eb1fb231d2f8d33689bfb3::sealsnut {
    struct SEALSNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALSNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALSNUT>(arg0, 6, b"SealSnut", b"Seal Snut sui", b"Partly seal Partly squirrel Fully cute - what better way to honor the late and great P'nut on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731727337688.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEALSNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALSNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


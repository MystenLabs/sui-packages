module 0x47c442027387a650433f6ecefc8d9d5481f13b0edacd6084752390553e1d5273::stg_01 {
    struct STG_01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG_01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG_01>(arg0, 7, b"STG_01", b"STG01", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://archive.cetus.zone/assets/image/sui/sui.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STG_01>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STG_01>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STG_01>>(v2);
    }

    // decompiled from Move bytecode v6
}


module 0x377b28ef2f3252445590d8b154b7cfdb3d1b282ee09beabca2601155911fe0b3::Shiva {
    struct SHIVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIVA>(arg0, 6, b"$SHIV", b"Shiva Token", b"TG : https://t.me/shiv_sui , Website: ", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIVA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIVA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


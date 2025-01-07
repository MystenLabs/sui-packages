module 0x4d8391d95c806e0c599f7be31f71a8017f333898632fcfa72a8dff180cdc2d15::dogsui {
    struct DOGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSUI>(arg0, 6, b"DogSui", b"Dog go To the moon S", x"41207072696d65697261206d656d6520636f696e20646f20426974636f696e2061676f726120657374c3a1206e61207265646520737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732760314606.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x79e3bed2ab387106ff8ae284abffaa06e7950201ea77f7a09379d06d80810e14::grnch {
    struct GRNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRNCH>(arg0, 6, b"GRNCH", b"Grinch", b"Staring down at Whoville with his sour grinchy frown.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732669095948.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRNCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRNCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


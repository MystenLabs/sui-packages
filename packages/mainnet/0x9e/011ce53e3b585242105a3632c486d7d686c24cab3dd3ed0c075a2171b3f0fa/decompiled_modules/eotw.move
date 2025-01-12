module 0x9e011ce53e3b585242105a3632c486d7d686c24cab3dd3ed0c075a2171b3f0fa::eotw {
    struct EOTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: EOTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EOTW>(arg0, 6, b"EOTW", b"End of The World", b"End of The World in Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736695455572.47")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EOTW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EOTW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


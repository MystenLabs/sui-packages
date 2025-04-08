module 0x14ced7ee35313d201e9f7fc076413ecb82e340c119360d0e38edabc5543069ae::tfo {
    struct TFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFO>(arg0, 6, b"TFO", b"TUFO", x"404f66696369616c5455464f0a5455464f3a20c2bf517565207061736172c3ad6120736920756e20616c69656e207365207469726120756e207065646f20656e206c6120626c6f636b636861696e3f20c2a156616d6f732061206176657269677561726c6f206a756e746f7321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1744139462183.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TFO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x242e1fdd0740d76d0f534bb4b10331e8b060bd4870fe97beaedf00690dc8e03b::suibull {
    struct SUIBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBULL>(arg0, 6, b"SUIBULL", b"SUI BULLRUN", x"53756962756c6c20546f6b656e204465736372697074696f6e0a53756962756c6c206973206120636f6d6d756e6974792d64726976656e20746f6b656e206275696c74206f6e207468652053756920626c6f636b636861696e2c2064657369676e656420746f20656d706f77657220646563656e7472616c697a65642066696e616e63652028446546692920616e6420666f7374657220696e6e6f766174696f6e2077697468696e20746865205375692065636f73797374656d2e2041732061206e617469766520746f6b656e2c2053756962756c6c206c657665726167657320537569e280997320686967682d7468726f756768707574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747932408579.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


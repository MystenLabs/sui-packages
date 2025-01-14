module 0x7601eb02a29b06513174c507e472ae9cfc4f8147280ae8f94001a5eade407ff3::rednote {
    struct REDNOTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDNOTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDNOTE>(arg0, 6, b"REDNOTE", b"Chinese Tiktok", x"57697468207468652054696b746f6b2062616e206c6f6f6d696e672061206e6577207472656e642f6d656d652068617320656d6572676564212054696b746f6b2075736572732061726520646f776e6c6f6164696e67205265646e6f746528e5b08fe7baa2e4b9a6292061732074686520756c74696d617465207361666520686176656e20666f7220616c6c20416d65726963616e2054696b546f6b20726566756765657320616e64202331206d6f737420646f776e6c6f6164656420617070206f6e20746865206170702073746f726521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736864948429.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REDNOTE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDNOTE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


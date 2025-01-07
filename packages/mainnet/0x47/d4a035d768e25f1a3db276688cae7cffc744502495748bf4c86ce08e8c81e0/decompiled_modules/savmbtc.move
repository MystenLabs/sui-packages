module 0x47d4a035d768e25f1a3db276688cae7cffc744502495748bf4c86ce08e8c81e0::savmbtc {
    struct SAVMBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVMBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVMBTC>(arg0, 6, b"SAVMBTC", b"SAVM", b"SAVM ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29095_b3598b31a5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVMBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAVMBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}


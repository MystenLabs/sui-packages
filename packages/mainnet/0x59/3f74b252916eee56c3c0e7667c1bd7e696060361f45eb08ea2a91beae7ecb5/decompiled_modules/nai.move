module 0x593f74b252916eee56c3c0e7667c1bd7e696060361f45eb08ea2a91beae7ecb5::nai {
    struct NAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAI>(arg0, 6, b"NAI", b"Nexus AI", b"An AI Agent mascot contributing a small effort toward the success of a bright future for the Web3 world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736157631157.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


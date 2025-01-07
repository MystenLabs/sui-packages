module 0x1f653961c8ab3aa4aaebb58fd36f26d56b6b80d8e8034bec7d130a657a3503a::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY>(arg0, 6, b"Capy", b"Capybaras", b"SuiFrens are beloved imaginative, inventive creatures traversing the internet, seeking fellow pioneers to build new connections and friendships.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731794434767.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


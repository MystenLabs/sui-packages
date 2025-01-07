module 0x8a453db43a891f36fd28a89341d1de25a1440c0576dc789658056ffdf99283b6::walrus {
    struct WALRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUS>(arg0, 6, b"Walrus", b"Walrus On Turbos", b"Walrus Walrus Walrus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956834452.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALRUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


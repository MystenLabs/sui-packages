module 0xd5e7f675e1c9b0c089ebe91cb60c4abf6e835669861daa552578020895c3e9a3::lwieq {
    struct LWIEQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LWIEQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LWIEQ>(arg0, 6, b"Lwieq", b"Lwmnek", b"WLNwqn w", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731158216902.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LWIEQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LWIEQ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


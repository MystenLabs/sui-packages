module 0x354708d35c824136832fd688ddf3333a53ea9534f6ee7b6870af0f4b705616fe::piens {
    struct PIENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIENS>(arg0, 6, b"PIENS", b"Suipiens", b"OG Community on $Sui Ecosystem.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730961231940.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIENS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIENS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


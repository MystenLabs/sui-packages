module 0x711b40406ba46193e3f3c506455560c7dbf22a734fbdf90e7c5d62722a1e05bf::voody {
    struct VOODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOODY>(arg0, 6, b"VOODY", b"Voody Sui", b"Vini Voody Vici", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738432433928.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOODY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOODY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


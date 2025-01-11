module 0x364a2a007c3174bb470758d05426dd76fb41af6f32e6661bf46ea0204f29ef88::lui {
    struct LUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUI>(arg0, 6, b"Lui", b"Doctor Lui", b"The Doctor Has Arrived on Sui! Heres the prescription for crypto: $Lui Bringing a healthy dose of fun and profit to the Sui network! Dr. Lui is known as the beloved face of the crypto world and the mascot of health-themed blockchain projects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736560742439.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


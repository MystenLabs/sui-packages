module 0x54d18dc78653668c4337627ca78311fb345edde8acb53df25f27d0986721a29e::eel {
    struct EEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEL>(arg0, 6, b"Eel", b"Garden eels", b"Garden eels are social animals and will keep a certain distance from their classmates. Much like us, everyone is in the cryptocurrency market, but they are all distanced from each other.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732639300842.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


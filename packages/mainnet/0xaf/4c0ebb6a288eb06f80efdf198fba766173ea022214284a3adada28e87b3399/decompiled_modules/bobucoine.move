module 0xaf4c0ebb6a288eb06f80efdf198fba766173ea022214284a3adada28e87b3399::bobucoine {
    struct BOBUCOINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBUCOINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBUCOINE>(arg0, 9, b"BOBUCOINE", b"BOBUC", b"Bobuc coin top", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b525e302-0357-494c-a7c0-8f4ab08add5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBUCOINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBUCOINE>>(v1);
    }

    // decompiled from Move bytecode v6
}


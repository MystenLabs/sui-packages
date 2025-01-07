module 0x68cf4bad52513166779990555120accc763e5a54898ed3c7b9a2f82142528b8f::nywewe {
    struct NYWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYWEWE>(arg0, 9, b"NYWEWE", b"LOVER OLD", b"Same beautiful concept", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36f87d4c-63d8-41ef-824d-f292ee802146.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xc681a333d5f1366ae4467e547133fbc3bdaa2ca4718584555d59f72faa2aa170::mono {
    struct MONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONO>(arg0, 9, b"MONO", b"Funny dog", b"my funny sugar dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4901143b-030c-4cd4-84da-8075ea8f4ada.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONO>>(v1);
    }

    // decompiled from Move bytecode v6
}


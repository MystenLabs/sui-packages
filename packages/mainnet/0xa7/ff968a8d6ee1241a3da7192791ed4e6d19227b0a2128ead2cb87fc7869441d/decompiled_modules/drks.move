module 0xa7ff968a8d6ee1241a3da7192791ed4e6d19227b0a2128ead2cb87fc7869441d::drks {
    struct DRKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRKS>(arg0, 9, b"DRKS", b"DARKNESS", b"DARKNESS LOVERS = THIS COIN LOVERS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/125253b3-ee81-415a-b606-a8e040746cd5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRKS>>(v1);
    }

    // decompiled from Move bytecode v6
}


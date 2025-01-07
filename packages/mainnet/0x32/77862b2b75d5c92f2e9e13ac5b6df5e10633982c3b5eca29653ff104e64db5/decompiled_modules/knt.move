module 0x3277862b2b75d5c92f2e9e13ac5b6df5e10633982c3b5eca29653ff104e64db5::knt {
    struct KNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNT>(arg0, 9, b"KNT", b"Knight", b"The knight is the king of many moves in the game of chess ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86b671c7-6522-445a-907e-98cee98de8d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNT>>(v1);
    }

    // decompiled from Move bytecode v6
}


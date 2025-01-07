module 0xd75b925b96adf9a03f5f76bd0d500e6c4d370e19443217ac54fe40d7f954c3db::finder {
    struct FINDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINDER>(arg0, 9, b"FINDER", b"Sui Finder", b"$FINDER is Sui Memecoin that loves Airdrop Finder Community (The Biggest Airdrop Community) Wen Airdrop?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a54b6c86-1f8e-453d-8444-2500b9d660a3-1000035434.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FINDER>>(v1);
    }

    // decompiled from Move bytecode v6
}


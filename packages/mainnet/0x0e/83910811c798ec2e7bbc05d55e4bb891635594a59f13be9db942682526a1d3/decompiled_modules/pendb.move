module 0xe83910811c798ec2e7bbc05d55e4bb891635594a59f13be9db942682526a1d3::pendb {
    struct PENDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENDB>(arg0, 9, b"PENDB", b"jeken", b"hebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5026e6af-a6a1-4ec9-b387-fc69d3fe175d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENDB>>(v1);
    }

    // decompiled from Move bytecode v6
}


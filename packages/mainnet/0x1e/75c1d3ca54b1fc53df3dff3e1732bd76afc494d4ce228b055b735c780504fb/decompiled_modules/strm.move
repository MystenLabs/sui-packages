module 0x1e75c1d3ca54b1fc53df3dff3e1732bd76afc494d4ce228b055b735c780504fb::strm {
    struct STRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRM>(arg0, 9, b"STRM", b"STORM", b"$Storm is a meme coin built on $SUI network and it is driven by social media hype and community support. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9b9868c-2206-447b-a573-b8964cf51cde.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRM>>(v1);
    }

    // decompiled from Move bytecode v6
}


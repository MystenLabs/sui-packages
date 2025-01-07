module 0x6836ae9d64a4db6408ee3c7ad6ef41b7cd62291bf954a6920c3916679ec4130c::opt {
    struct OPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPT>(arg0, 9, b"OPT", b"Optimistic", b"Always be optimistic and confident.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f564216-c336-4983-91e3-fe25e31bd1be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPT>>(v1);
    }

    // decompiled from Move bytecode v6
}


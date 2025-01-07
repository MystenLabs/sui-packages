module 0x3d46e6ebd492c582308139ae2c53a55224dce9ae5eab85976775ebae50818cc3::opt {
    struct OPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPT>(arg0, 9, b"OPT", b"Optimistic", b"Always be optimistic and confident.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d8fc250-a180-4e18-9c36-3d886550fc58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPT>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x105116335cbe00e53df99e23d07eda57a71efb1e1cb39ec56f5b2f2917b74767::sct {
    struct SCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCT>(arg0, 9, b"SCT", b"SUICAT", b"A meme coin on Sui Blockchain that is mean to immortalized a cat that has a historical record on the Genesis of SUI as a Blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95a6fda7-3422-4add-9c4e-2a8edff55c18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCT>>(v1);
    }

    // decompiled from Move bytecode v6
}


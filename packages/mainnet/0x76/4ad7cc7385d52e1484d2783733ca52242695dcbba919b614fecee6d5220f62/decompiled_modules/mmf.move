module 0x764ad7cc7385d52e1484d2783733ca52242695dcbba919b614fecee6d5220f62::mmf {
    struct MMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMF>(arg0, 9, b"MMF", b"Meme fun", b"Meme for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/84af9e02-81f7-415b-8214-36944be3cfae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMF>>(v1);
    }

    // decompiled from Move bytecode v6
}


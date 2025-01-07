module 0x997125f22fbbaa58d0f1e86da5f4672ab09902c8e33533dd523cc1a4ce71342c::mmf {
    struct MMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMF>(arg0, 9, b"MMF", b"Meme fun", b"Meme for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c4287b2-0f14-4529-bfd3-5a93614ac829.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMF>>(v1);
    }

    // decompiled from Move bytecode v6
}


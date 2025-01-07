module 0x41bfdac42099b614242a249dca48d3cec102df2f30e3dce2de2341a47714997c::dogesui {
    struct DOGESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESUI>(arg0, 9, b"DOGESUI", b"doge sui", b"Meme doge on sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fd492d8-a218-43a5-a9a2-037b6fff8ff2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


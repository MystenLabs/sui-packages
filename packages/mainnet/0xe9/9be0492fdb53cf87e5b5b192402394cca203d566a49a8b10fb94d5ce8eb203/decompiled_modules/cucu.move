module 0xe99be0492fdb53cf87e5b5b192402394cca203d566a49a8b10fb94d5ce8eb203::cucu {
    struct CUCU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCU>(arg0, 9, b"CUCU", b"Cucurut", b"Future memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f14c7c45-c2b4-402f-bd17-fd8c2f9a88c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUCU>>(v1);
    }

    // decompiled from Move bytecode v6
}


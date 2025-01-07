module 0xd38dc78f372097115456cf886f7a2c346d145c09b92104780e9dc2dcd30b2757::adffghhhhj {
    struct ADFFGHHHHJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADFFGHHHHJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADFFGHHHHJ>(arg0, 9, b"ADFFGHHHHJ", b"HANGWAve", b"how are u today", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71621598-7211-416d-9e16-ad44e417fdca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADFFGHHHHJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADFFGHHHHJ>>(v1);
    }

    // decompiled from Move bytecode v6
}


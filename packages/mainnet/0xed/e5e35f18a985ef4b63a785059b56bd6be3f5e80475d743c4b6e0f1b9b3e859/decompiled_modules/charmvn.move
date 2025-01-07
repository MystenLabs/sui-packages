module 0xede5e35f18a985ef4b63a785059b56bd6be3f5e80475d743c4b6e0f1b9b3e859::charmvn {
    struct CHARMVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARMVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARMVN>(arg0, 9, b"CHARMVN", b"CHARM", b"Token for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aef8d98f-048c-4d7f-b1d0-1f9a32436436.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARMVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHARMVN>>(v1);
    }

    // decompiled from Move bytecode v6
}


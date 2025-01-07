module 0xc42b76659419d93a81c00f69bd0e5c37154528cbf08736fb5ab36dfe492981d5::droppy {
    struct DROPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPPY>(arg0, 6, b"Droppy", b"DroppyOnSui", b"Play the Droppy on Sui Telegram minigame", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t0_OC_Trba_400x400_352f4240d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


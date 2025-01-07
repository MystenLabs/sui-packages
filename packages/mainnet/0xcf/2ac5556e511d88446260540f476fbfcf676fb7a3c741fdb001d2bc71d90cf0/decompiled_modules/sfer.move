module 0xcf2ac5556e511d88446260540f476fbfcf676fb7a3c741fdb001d2bc71d90cf0::sfer {
    struct SFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFER>(arg0, 6, b"SFER", b"Sui fer", b"Sui is now suifer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_e15ba7121e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFER>>(v1);
    }

    // decompiled from Move bytecode v6
}


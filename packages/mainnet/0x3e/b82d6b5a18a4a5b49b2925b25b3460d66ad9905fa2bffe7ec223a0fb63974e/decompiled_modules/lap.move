module 0x3eb82d6b5a18a4a5b49b2925b25b3460d66ad9905fa2bffe7ec223a0fb63974e::lap {
    struct LAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAP>(arg0, 9, b"LAP", b"Lapthsu", b"lap meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76659696-d148-4191-b12a-b57874248f93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAP>>(v1);
    }

    // decompiled from Move bytecode v6
}


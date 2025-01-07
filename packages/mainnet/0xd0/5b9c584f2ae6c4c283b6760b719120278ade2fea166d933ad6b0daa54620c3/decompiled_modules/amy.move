module 0xd05b9c584f2ae6c4c283b6760b719120278ade2fea166d933ad6b0daa54620c3::amy {
    struct AMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMY>(arg0, 9, b"AMY", b"Amygrace", b"My name is Amara ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3f36114-f2ac-49bd-b14f-b3e4d6a1cde5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMY>>(v1);
    }

    // decompiled from Move bytecode v6
}


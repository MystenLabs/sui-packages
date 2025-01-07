module 0x91e83e4aae4e5789afd2860773624d86d239b388d49733b35899a53f7a211416::kioki {
    struct KIOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIOKI>(arg0, 9, b"KIOKI", b"Kioko", b"Meme for pogies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c76124fc-23e0-40fe-b452-1f4bdcfe9a4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}


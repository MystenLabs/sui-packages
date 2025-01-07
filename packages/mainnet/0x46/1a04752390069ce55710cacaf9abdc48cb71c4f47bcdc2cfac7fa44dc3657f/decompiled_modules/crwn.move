module 0x461a04752390069ce55710cacaf9abdc48cb71c4f47bcdc2cfac7fa44dc3657f::crwn {
    struct CRWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRWN>(arg0, 9, b"CRWN", b"Crown", b"These meme token was created from my traditional yoruba name, Adetunji Adefioye (Ade). Let's come together to celebrate a traditional yoruba name from Nigeria. Thank you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4748e415-389f-4f76-8012-0bfb1f58f6bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRWN>>(v1);
    }

    // decompiled from Move bytecode v6
}


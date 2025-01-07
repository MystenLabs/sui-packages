module 0xdb6ec8584a036096726665664867baa4794b055df85cb517f416b78fce061668::yay {
    struct YAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAY>(arg0, 9, b"YAY", b"Yay coin", b"The coin that makes you go \"yaaaaay!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ac03d79-0963-40f4-a5e4-5fda2ec67474-raf,360x360,075,t,fafafa_ca443f4786.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAY>>(v1);
    }

    // decompiled from Move bytecode v6
}


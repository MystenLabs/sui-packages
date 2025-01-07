module 0x144a1a9ba8fec11fe6d0060926f58d459c17c232236d394d97b8a7cbb56bf043::yay {
    struct YAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAY>(arg0, 9, b"YAY", b"Yay coin", b"The coin that makes you go \"yaaaaay!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5bc87f3-aaa3-4121-8b8f-7573c4e7f9e1-raf,360x360,075,t,fafafa_ca443f4786.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAY>>(v1);
    }

    // decompiled from Move bytecode v6
}


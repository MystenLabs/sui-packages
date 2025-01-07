module 0x77cc4edd037e5cd4790c805179506c057b0cee2817e6c442c3cd5d84ca53f589::ubt {
    struct UBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: UBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UBT>(arg0, 9, b"UBT", b"Ubuntu", b"Ubuntu is an ancient African word meaning 'humanity to others'. It is often described as reminding us that 'I am what I am because of who we all are'.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f764571a-a032-474c-bb86-00bc9f124358.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UBT>>(v1);
    }

    // decompiled from Move bytecode v6
}


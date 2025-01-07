module 0x4b3e14b84b5ed608458abe425333d7b7054d0b48b7b8147c2ed7f8fab825770a::bakso {
    struct BAKSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKSO>(arg0, 9, b"BAKSO", b"Bakso Bang", b"Inspired by traditional Indonesian food, namely yummy meatballs!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/41fd776b-d0f3-43be-9911-11c780d996c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAKSO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xee2bd7b341d7b25fdfd9a2e25b03012fde8a703bde517cd19285a89e8bca6056::wacat {
    struct WACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WACAT>(arg0, 9, b"WACAT", b"WAWE", b"WAWE is a meme inspired by the spirit of adventure and freedom. with WAWE, we are not just riding the waves. We are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb095da0-c3b7-4397-b1cf-92725bb8b7c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


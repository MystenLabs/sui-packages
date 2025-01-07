module 0x5703ec60130e958b3f487cb986732f5cb10caf6fbb3c171093294aeaf2a2aafb::wegot {
    struct WEGOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEGOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEGOT>(arg0, 9, b"WEGOT", b"WAWE", b"WAWE is a meme inspired by the spirit of adventure and freedom with WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad3a71dc-782e-4ba1-9e7c-eb07d5d36983.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEGOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEGOT>>(v1);
    }

    // decompiled from Move bytecode v6
}


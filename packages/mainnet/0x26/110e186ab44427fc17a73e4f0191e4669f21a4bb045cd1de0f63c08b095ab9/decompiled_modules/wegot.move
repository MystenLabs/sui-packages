module 0x26110e186ab44427fc17a73e4f0191e4669f21a4bb045cd1de0f63c08b095ab9::wegot {
    struct WEGOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEGOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEGOT>(arg0, 9, b"WEGOT", b"WAWE", b"WAWE is a meme inspired by the spirit of adventure and freedom with WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc91bffd-6149-4f3b-8b29-feeb3e75eba6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEGOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEGOT>>(v1);
    }

    // decompiled from Move bytecode v6
}


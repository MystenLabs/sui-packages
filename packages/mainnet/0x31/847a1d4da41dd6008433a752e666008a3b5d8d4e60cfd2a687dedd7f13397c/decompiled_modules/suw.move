module 0x31847a1d4da41dd6008433a752e666008a3b5d8d4e60cfd2a687dedd7f13397c::suw {
    struct SUW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUW>(arg0, 9, b"SUW", b"Suiwewe", b"Wewe in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a7c354a-8d38-474b-93b9-8bfe9c4dbe8c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUW>>(v1);
    }

    // decompiled from Move bytecode v6
}


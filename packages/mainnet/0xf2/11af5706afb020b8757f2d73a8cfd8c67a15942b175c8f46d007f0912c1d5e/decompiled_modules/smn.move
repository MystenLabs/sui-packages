module 0xf211af5706afb020b8757f2d73a8cfd8c67a15942b175c8f46d007f0912c1d5e::smn {
    struct SMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMN>(arg0, 9, b"SMN", b"Suimoon", b"Greatest meme on sui, going to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31737a7b-6f1e-4843-a1fd-93dec4f5cfd3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMN>>(v1);
    }

    // decompiled from Move bytecode v6
}


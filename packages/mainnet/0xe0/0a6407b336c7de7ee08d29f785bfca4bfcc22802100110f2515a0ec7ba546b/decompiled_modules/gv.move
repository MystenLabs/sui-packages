module 0xe00a6407b336c7de7ee08d29f785bfca4bfcc22802100110f2515a0ec7ba546b::gv {
    struct GV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GV>(arg0, 9, b"GV", b"FSA", b"DFS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04d817e2-b1c2-4df0-9d11-56f653e4e9ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GV>>(v1);
    }

    // decompiled from Move bytecode v6
}


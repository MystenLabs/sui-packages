module 0xbe5fe4c1ef3b1fabc056433d797e54b6a5a489aadcaec145f63c7d9dc0deac17::gv {
    struct GV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GV>(arg0, 9, b"GV", b"FSA", b"DFS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3a02411-8324-4c90-82da-9193785b1dd7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GV>>(v1);
    }

    // decompiled from Move bytecode v6
}


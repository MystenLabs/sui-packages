module 0x5b602f2a716ba9bb85e0f5f98606fc11bf5462f53524156221290abe974949c5::lop {
    struct LOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOP>(arg0, 9, b"LOP", b"LOPPY", b"Loppy for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aebc558b-ac90-43ac-9b61-7f2a233f6a6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOP>>(v1);
    }

    // decompiled from Move bytecode v6
}


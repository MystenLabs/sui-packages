module 0xaffb2f89fe450c8a0986e36f203db832443f5678fad795b9baee573063b5e970::nmk {
    struct NMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NMK>(arg0, 9, b"NMK", b"Namek", b"The most efficient solutions for web3. Update your score level. DBZ MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18a813b6-ed67-4f32-96a1-33d334e8341e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NMK>>(v1);
    }

    // decompiled from Move bytecode v6
}


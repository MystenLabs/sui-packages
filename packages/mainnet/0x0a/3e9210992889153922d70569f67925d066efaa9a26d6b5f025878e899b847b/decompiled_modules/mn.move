module 0xa3e9210992889153922d70569f67925d066efaa9a26d6b5f025878e899b847b::mn {
    struct MN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MN>(arg0, 9, b"MN", b"Moon", b"A meme token under sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a34884b9-5e13-4b05-9eb6-3d7de166c7e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MN>>(v1);
    }

    // decompiled from Move bytecode v6
}


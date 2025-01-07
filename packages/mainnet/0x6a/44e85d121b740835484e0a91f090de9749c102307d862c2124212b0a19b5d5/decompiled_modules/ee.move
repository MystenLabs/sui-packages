module 0x6a44e85d121b740835484e0a91f090de9749c102307d862c2124212b0a19b5d5::ee {
    struct EE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EE>(arg0, 9, b"EE", b"Where ", b"Nb the first thing I thought ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/911a2699-92ac-4e1e-9671-9ba823f6e9a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EE>>(v1);
    }

    // decompiled from Move bytecode v6
}


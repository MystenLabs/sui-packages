module 0xae6d1350e28319dd9188a44fb46584c621d044f0a2fbb709869eb74c29551612::l {
    struct L has drop {
        dummy_field: bool,
    }

    fun init(arg0: L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L>(arg0, 9, b"L", b"lady", b"lady are beautiful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7bb73aa-92d2-4241-84dd-e2900b976c08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L>>(v1);
    }

    // decompiled from Move bytecode v6
}


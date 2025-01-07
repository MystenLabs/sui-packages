module 0xd11b72a9bff1c9dc33afc28f2f13c1e196d7059983de80995f14f27f67e0a667::plend {
    struct PLEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLEND>(arg0, 9, b"PLEND", b"benen", b"bebsx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96483ff3-d964-4065-a1f5-afee3cbbe187.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLEND>>(v1);
    }

    // decompiled from Move bytecode v6
}


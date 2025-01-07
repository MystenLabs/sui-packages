module 0x7d742a131d8f5dab4abc5d4e76555d0a2f5a245f1cf02dd8abd083cdb60863f3::wol {
    struct WOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOL>(arg0, 9, b"WOL", b"WOLF", b"\"Howl at the Moon: Introducing $WOLF, the token that brings crypto investors together, wild and free.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c5600cb-040d-43b6-98b5-1178d8525c62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOL>>(v1);
    }

    // decompiled from Move bytecode v6
}


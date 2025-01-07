module 0xa682a417b1644f6e03edf1d7f370ac4a84aa636f486b166f52f775dacd09b62f::rathva {
    struct RATHVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATHVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATHVA>(arg0, 9, b"RATHVA", b"Mongo", b"Muje Aacha laga ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb40c99c-f6d0-4c2d-8795-130b32e208e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATHVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RATHVA>>(v1);
    }

    // decompiled from Move bytecode v6
}


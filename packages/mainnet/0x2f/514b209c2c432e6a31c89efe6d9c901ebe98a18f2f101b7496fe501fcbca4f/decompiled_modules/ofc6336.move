module 0x2f514b209c2c432e6a31c89efe6d9c901ebe98a18f2f101b7496fe501fcbca4f::ofc6336 {
    struct OFC6336 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFC6336, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFC6336>(arg0, 9, b"OFC6336", b"OFC", b"OrderFC Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd0f8b28-2ed6-454b-9fef-236a10609dc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFC6336>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OFC6336>>(v1);
    }

    // decompiled from Move bytecode v6
}


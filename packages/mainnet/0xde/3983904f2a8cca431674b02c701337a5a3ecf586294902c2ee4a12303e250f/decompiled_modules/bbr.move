module 0xde3983904f2a8cca431674b02c701337a5a3ecf586294902c2ee4a12303e250f::bbr {
    struct BBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBR>(arg0, 9, b"BBR", b"BOBR", b"Free the beavers!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0231db9-c4c6-49a2-987a-53c544934736.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBR>>(v1);
    }

    // decompiled from Move bytecode v6
}


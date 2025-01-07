module 0xc6dba33d229b40c1beed06aeb66a550df05d20d15fced81164a2784463d65fa9::eb {
    struct EB has drop {
        dummy_field: bool,
    }

    fun init(arg0: EB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EB>(arg0, 9, b"EB", b"E", b"Xxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08834a0b-7ac5-4670-ac64-9ffeb24c3b6e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EB>>(v1);
    }

    // decompiled from Move bytecode v6
}


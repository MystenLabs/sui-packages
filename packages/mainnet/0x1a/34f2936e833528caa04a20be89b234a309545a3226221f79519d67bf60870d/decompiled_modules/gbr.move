module 0x1a34f2936e833528caa04a20be89b234a309545a3226221f79519d67bf60870d::gbr {
    struct GBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBR>(arg0, 9, b"GBR", b"KHP", b"Going out to eat with ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98f1752b-92dd-4db6-a4fe-f7706c9cb76d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBR>>(v1);
    }

    // decompiled from Move bytecode v6
}


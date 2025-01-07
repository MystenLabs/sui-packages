module 0xf697ad2c365bad4f6bee4e4dd938a511e4ee848fa8c598ee050ce6c9a24479d5::mig {
    struct MIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIG>(arg0, 9, b"MIG", b"MIGII", b"New token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9524d3ab-2983-46d1-9b1e-7daea26c4685.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIG>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x4613673678a05fffdd0fdb83fdab3bbf50b3950a2c7a697d969f6131667846f9::mnt {
    struct MNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNT>(arg0, 9, b"MNT", b"MINT", b"Many New Things ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d960c06e-a51a-40e0-af47-dc4bb2528645.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNT>>(v1);
    }

    // decompiled from Move bytecode v6
}


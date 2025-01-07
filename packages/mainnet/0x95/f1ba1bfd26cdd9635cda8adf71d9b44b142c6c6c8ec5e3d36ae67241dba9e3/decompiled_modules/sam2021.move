module 0x95f1ba1bfd26cdd9635cda8adf71d9b44b142c6c6c8ec5e3d36ae67241dba9e3::sam2021 {
    struct SAM2021 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM2021, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAM2021>(arg0, 9, b"SAM2021", b"Sam", b"Gag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ef1fa5d-6c53-4b4b-a88c-5dbe65a231c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAM2021>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAM2021>>(v1);
    }

    // decompiled from Move bytecode v6
}


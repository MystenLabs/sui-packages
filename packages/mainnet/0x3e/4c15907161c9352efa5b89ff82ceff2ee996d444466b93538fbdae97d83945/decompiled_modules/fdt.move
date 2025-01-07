module 0x3e4c15907161c9352efa5b89ff82ceff2ee996d444466b93538fbdae97d83945::fdt {
    struct FDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDT>(arg0, 9, b"FDT", b"Food", b"Foodchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db65ad27-79c9-4fba-9e76-f376f7526992.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDT>>(v1);
    }

    // decompiled from Move bytecode v6
}


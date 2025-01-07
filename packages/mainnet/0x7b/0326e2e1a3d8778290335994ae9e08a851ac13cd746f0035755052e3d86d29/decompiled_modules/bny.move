module 0x7b0326e2e1a3d8778290335994ae9e08a851ac13cd746f0035755052e3d86d29::bny {
    struct BNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNY>(arg0, 9, b"BNY", b"Bunny", b"Bunny bunny ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16a89bc5-4c16-4ddd-b5e9-8155e57c6f56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNY>>(v1);
    }

    // decompiled from Move bytecode v6
}


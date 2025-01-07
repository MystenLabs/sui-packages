module 0x69f24374140d8c0e71f2c1fdafde735ff3c2dba4c233c2c1b6491ee3f768f60d::tmg {
    struct TMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMG>(arg0, 9, b"TMG", b"Tamago", b"Egg ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03640210-1abf-4ff0-b848-07d82d8eacea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMG>>(v1);
    }

    // decompiled from Move bytecode v6
}


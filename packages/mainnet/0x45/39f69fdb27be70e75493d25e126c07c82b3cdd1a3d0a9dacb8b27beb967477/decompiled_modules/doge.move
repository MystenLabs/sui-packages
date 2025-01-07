module 0x4539f69fdb27be70e75493d25e126c07c82b3cdd1a3d0a9dacb8b27beb967477::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"4Doge", b"4DOGE isnt just another tokenits a powerful symbol representing all of us. Born from the heart of the DOGE family, 4DOGE stands for the values we cherish: loyalty, strength, innovation and healing. Stands for CZ, for decentralisation and each of us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727091403836_6355f56bc1be0bd8f7d220c1599462b0_f282e0b6a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}


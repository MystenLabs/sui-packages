module 0x2563d9510a848d3f9390d188cc39b9759e346d2482630815ba331907ae9eb079::doge4 {
    struct DOGE4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE4>(arg0, 6, b"DOGE4", b"4Doge", b"4DOGE isnt just another tokenits a powerful symbol representing all of us. Born from the heart of the DOGE family, 4DOGE stands for the values we cherish: loyalty, strength, innovation and healing. Stands for CZ, for decentralisation and each of us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727091403836_6355f56bc1be0bd8f7d220c1599462b0_f282e0b6a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE4>>(v1);
    }

    // decompiled from Move bytecode v6
}


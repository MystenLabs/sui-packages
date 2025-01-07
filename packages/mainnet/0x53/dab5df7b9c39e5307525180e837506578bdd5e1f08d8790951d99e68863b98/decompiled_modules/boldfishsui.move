module 0x53dab5df7b9c39e5307525180e837506578bdd5e1f08d8790951d99e68863b98::boldfishsui {
    struct BOLDFISHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLDFISHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLDFISHSUI>(arg0, 6, b"BOLDFISHSUI", b"KOI ON SUI", b"A Bold Fish Making Waves of Wealth in the Sui Ocean ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_13_215210821_c9d6be0e81.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLDFISHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLDFISHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


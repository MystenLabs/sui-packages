module 0xef76e84a7f5b5e9ab5034c866d2269bd28ac2d3c34a4df22fa15a2ad4b5a8012::crosui {
    struct CROSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROSUI>(arg0, 6, b"CroSUI", b"CrocoSUI", b"CrocoSUI is the latest memecoin on the SUI network, featuring a fierce yet fun crocodile mascot. Combining the sharp edge of crypto with the playful spirit of memes, CrocoSUI is here to snap up attention and take a big bite out of the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kroki_bfce69ead3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


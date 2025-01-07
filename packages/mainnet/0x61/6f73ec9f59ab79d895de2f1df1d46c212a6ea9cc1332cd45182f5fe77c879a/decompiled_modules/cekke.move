module 0x616f73ec9f59ab79d895de2f1df1d46c212a6ea9cc1332cd45182f5fe77c879a::cekke {
    struct CEKKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEKKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEKKE>(arg0, 6, b"CEKKE", b"Cekke Sui", b"CekkeSUI MEME OF SUI AND EVERYONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jp4mhf_D8_400x400_31b0ddaad9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEKKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEKKE>>(v1);
    }

    // decompiled from Move bytecode v6
}


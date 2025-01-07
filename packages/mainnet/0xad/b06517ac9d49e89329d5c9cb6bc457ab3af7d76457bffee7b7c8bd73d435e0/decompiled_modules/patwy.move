module 0xadb06517ac9d49e89329d5c9cb6bc457ab3af7d76457bffee7b7c8bd73d435e0::patwy {
    struct PATWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATWY>(arg0, 6, b"PATWY", b"Sui Patwy", b"PATWY -  the cute Memecoin that will become an icon on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014727_f198f3c251.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATWY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x255e2a08018a090131df87869c660a4868639d90529b4e408729b6e15bab2836::suiryoshi {
    struct SUIRYOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRYOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRYOSHI>(arg0, 6, b"SUIRYOSHI", b"Sui Ryoshi", b"Sui Ryoshi just dropped on SUI, and it's lit! This token's got the vibes of a chill sunrise and the wisdom of some ancient master, all rolled into one.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_tela_2024_10_04_232209_a425fe275c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRYOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRYOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}


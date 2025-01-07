module 0xd5c8215ba7ce56e64ff74a89fbd31781248dadf20290cbb4b234277da4165aa::sdino {
    struct SDINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDINO>(arg0, 6, b"SDINO", b"Dino Dance On Sui", b"The funny dinosaur celebrates Sui's return to the throne.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dinogif_d266fe0693_21779edf8b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDINO>>(v1);
    }

    // decompiled from Move bytecode v6
}


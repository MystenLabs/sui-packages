module 0xbe1757e18f6cde3313a69414557bc73edbfacefb79f69aa457d996356be35419::suicraftcoin {
    struct SUICRAFTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICRAFTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICRAFTCOIN>(arg0, 6, b"Suicraftcoin", b"Suicraft", b"Get ready to dig deep into the world of crypto with $suicraft, the newest meme coin on the SUI network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2024_10_16_a_I_s_19_16_56_ac616d6ac4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICRAFTCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICRAFTCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


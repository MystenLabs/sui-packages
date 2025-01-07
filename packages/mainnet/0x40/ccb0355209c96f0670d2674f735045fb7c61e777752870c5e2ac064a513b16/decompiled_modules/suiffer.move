module 0x40ccb0355209c96f0670d2674f735045fb7c61e777752870c5e2ac064a513b16::suiffer {
    struct SUIFFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFFER>(arg0, 6, b"SUIFFER", b"Suiffer the Pufferfish", b"Suiffer, just a pufferfish roaming the sea of Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_902345b825.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFFER>>(v1);
    }

    // decompiled from Move bytecode v6
}


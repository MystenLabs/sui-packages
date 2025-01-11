module 0x857c813aed1a8dbfac3a4cc1c8d048ba137d54e147c9fb11e29868876366c23d::ailoli {
    struct AILOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AILOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AILOLI>(arg0, 9, b"AILOLI", b"AILOLI", b"$AILOLI - is the key for the AI future | Language model | AI Trader |", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/QQ29xMC/w-Gw-KJFjq-Np-Tkc-G9-W87ghid-PD6z-J9g-Rnn-HDt-HSPNpump-modified.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AILOLI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AILOLI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AILOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x889c61d492394d182149914bdc13af9a58be3296389324de01cc5ec83705cad7::cod {
    struct COD has drop {
        dummy_field: bool,
    }

    fun init(arg0: COD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COD>(arg0, 6, b"COD", b"Call Of Diddy", b"Welcome to the Call of Diddywhere meme magic meets the battlefield! Get ready to drop in, squad up, and level up your crypto game. Just like in Call of Duty, teamwork and strategy are key.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Elfuuwr_I_400x400_28cb4e61be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COD>>(v1);
    }

    // decompiled from Move bytecode v6
}


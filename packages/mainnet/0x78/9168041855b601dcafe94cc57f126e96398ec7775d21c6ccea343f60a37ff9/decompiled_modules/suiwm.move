module 0x789168041855b601dcafe94cc57f126e96398ec7775d21c6ccea343f60a37ff9::suiwm {
    struct SUIWM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWM>(arg0, 6, b"SUIWM", b"SUI WASHING MACHINE", b"SUI Washing Machine: Where your crypto comes in dirty and spins out squeaky clean! In this \"totally legal\" laundry cycle, watch your tokens tumble through a world of wild market fluctuations. Just add your digital assets, hit spin, and let the SUI blockchain handle the restbecause nothing says clean like a little decentralized \"washing.\" Dont worry, it's all just part of the fun...right?  #DefinitelyNotMoneyLaundering", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sem_t_A_tulo_163a6bbea3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWM>>(v1);
    }

    // decompiled from Move bytecode v6
}


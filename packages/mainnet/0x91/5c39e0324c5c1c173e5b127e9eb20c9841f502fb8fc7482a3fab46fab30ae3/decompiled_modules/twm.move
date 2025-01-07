module 0x915c39e0324c5c1c173e5b127e9eb20c9841f502fb8fc7482a3fab46fab30ae3::twm {
    struct TWM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWM>(arg0, 6, b"TWM", b"Trump Washing Machine", b"Where your assets spin through the \"greatest cycle you've ever seen!\" Powered by huge promises and big market swings, this memecoin cleans your crypto \"better than anyone else could.\" Expect plenty of whirlpools, spin cycles, and maybe a tweet or two during the rinse. Its yuge, unpredictable, and sure to leave you dizzybut in the end, \"itll be the cleanest wash, believe me!\" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/perfil_d92afce8de.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWM>>(v1);
    }

    // decompiled from Move bytecode v6
}


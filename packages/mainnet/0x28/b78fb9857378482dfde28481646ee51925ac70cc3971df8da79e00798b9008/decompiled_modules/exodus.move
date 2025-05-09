module 0x28b78fb9857378482dfde28481646ee51925ac70cc3971df8da79e00798b9008::exodus {
    struct EXODUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXODUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXODUS>(arg0, 6, b"EXODUS", b"Exodus Sui", b"EXODUS Chapter One: The Chain Awakens In the beginning, there was chaos. Rugpulls ruled the land, gas fees drained the faithful, and false prophets lured the degen masses into shadowy tokens. The Base chain cried out for a savior. And so it was written $EXODUS emerged. Not built. Not launched. Summoned. A token forged in fire, freed from vanity tax and dev greed, born to lead the chosen few from the land of rugs to the valley of real gains. Its holders? Disciples. Its mission? Divine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000067920_af7d5a98fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXODUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EXODUS>>(v1);
    }

    // decompiled from Move bytecode v6
}


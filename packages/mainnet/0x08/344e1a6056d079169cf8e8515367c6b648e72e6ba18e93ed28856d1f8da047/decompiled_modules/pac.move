module 0x8344e1a6056d079169cf8e8515367c6b648e72e6ba18e93ed28856d1f8da047::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 6, b"PAC", b"America PAC", b"Join The America $PAC Movement! We support Trump and the tech billionaire SuperPacs backing him, like ElonMusk and the Winklevoss Twins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006831_4386df8a44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAC>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xdb9fa194ccce6c7903d087d29b28ff157254de659bb1cc63943766c8a3835437::niggabucks {
    struct NIGGABUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGABUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGABUCKS>(arg0, 6, b"Niggabucks", b"niggabucks", b"The Fartcoin of sui, following the meta on sol with a degen coin hopefully sui guys can leave there bubble and buy something retarded for once X is up tg soon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4287_fa9ba81210.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGABUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGABUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}


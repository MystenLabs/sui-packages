module 0xdae3110fea1f6476eccb41ec120f28f90250addf39fd95b267d65f548d42de63::girlycat {
    struct GIRLYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRLYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRLYCAT>(arg0, 9, b"GIRLYCAT", b"Dian", b"Cat meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c44ba045-eb2d-425e-a429-669199c7fcc3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRLYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIRLYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


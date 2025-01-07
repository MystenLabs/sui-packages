module 0x5b313d8de4962fd4be190e814ebc6c2694cf0ab52efdfc5f1b764cf4f2df11b6::ou {
    struct OU has drop {
        dummy_field: bool,
    }

    fun init(arg0: OU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OU>(arg0, 6, b"OU", b"/ \\__  (    @\\___  /         O /   (_____/ /_____/   U", x"0a2020202f205c5f5f0a20202820202020405c5f5f5f0a20202f20202020202020202020202020204f0a202f202020285f5f5f5f5f2f0a2f5f5f5f5f5f2f202020550a0a20200a606060", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2507_d21f2201cf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OU>>(v1);
    }

    // decompiled from Move bytecode v6
}


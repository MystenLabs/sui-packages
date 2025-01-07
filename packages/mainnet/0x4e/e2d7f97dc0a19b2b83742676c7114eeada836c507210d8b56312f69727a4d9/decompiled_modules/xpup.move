module 0x4ee2d7f97dc0a19b2b83742676c7114eeada836c507210d8b56312f69727a4d9::xpup {
    struct XPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPUP>(arg0, 6, b"Xpup", b"Xmas Pup", b"Santa Paws is coming to town, bringing wagging tails and holiday joy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/462565472_2281056065626939_5184357693371973372_n_6623be1854.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}


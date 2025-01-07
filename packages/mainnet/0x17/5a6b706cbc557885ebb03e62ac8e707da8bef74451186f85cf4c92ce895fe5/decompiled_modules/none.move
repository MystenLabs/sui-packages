module 0x175a6b706cbc557885ebb03e62ac8e707da8bef74451186f85cf4c92ce895fe5::none {
    struct NONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONE>(arg0, 6, b"NONE", b"NONE on SUI", x"6f757220636f6d6d756e697479206973206e756d626572206f6e652c206275742069732074686572652061206465763f20746865726520697320244e4f4e45210a746865206e616b6564206f6e65202d2023312053554920636f6d6d756e69747920262065636f73797374656d20666f72206465767320616e6420636174206c6f766572732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qttaw_D90_400x400_83ee77c2b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NONE>>(v1);
    }

    // decompiled from Move bytecode v6
}


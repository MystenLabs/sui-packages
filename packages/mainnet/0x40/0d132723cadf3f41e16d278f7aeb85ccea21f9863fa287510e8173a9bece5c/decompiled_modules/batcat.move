module 0x400d132723cadf3f41e16d278f7aeb85ccea21f9863fa287510e8173a9bece5c::batcat {
    struct BATCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATCAT>(arg0, 6, b"BATCAT", b"BATCAT SUI CHAIN", x"49276d20676f696e6720746f2068756e7420646f776e20616c6c207275672070756c6c7320696e207468652043697479206f6620527567730a4a6f696e20244241544341542041726d79", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mxyi_G_Zo_M_400x400_874d20461a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


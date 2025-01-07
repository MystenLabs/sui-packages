module 0xa2dd9f4175d07e7d9ed3fed3d1c77ad4278558850d6253f24ac79e3039c7888e::_superbowl {
    struct _SUPERBOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: _SUPERBOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<_SUPERBOWL>(arg0, 9, b"Superbowl", b"Superbowl", b"Superbowllllllllllllll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZtnrhAnG1lj4gnz0GAuhBFM9ltur7DJqyMw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<_SUPERBOWL>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<_SUPERBOWL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<_SUPERBOWL>>(v1);
    }

    // decompiled from Move bytecode v6
}


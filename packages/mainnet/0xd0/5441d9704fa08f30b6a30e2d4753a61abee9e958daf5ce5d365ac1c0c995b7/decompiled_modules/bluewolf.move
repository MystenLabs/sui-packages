module 0xd05441d9704fa08f30b6a30e2d4753a61abee9e958daf5ce5d365ac1c0c995b7::bluewolf {
    struct BLUEWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEWOLF>(arg0, 6, b"BlueWolf", b"Blue Wolf", b"The Wolf is a very special Arctic wilderness ash Wolf, large, flexible, very strong, living in the Arctic high point all the year round, but few people know about them, because the wolves are very effective and rare", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727875322917_61ddc1fd70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEWOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEWOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xa68f4051f961b7f8280504fefb4445766fa10fab2d5e7f1fe756259ad9c85b4c::crew {
    struct CREW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREW>(arg0, 9, b"CREW", b"CREWSUI", b"AI X manager. community-fueled everything.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPBtHuL6RGkVYq4HQ6C6oPPsRG8TzzXKmCYmwjSvcwArj")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CREW>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


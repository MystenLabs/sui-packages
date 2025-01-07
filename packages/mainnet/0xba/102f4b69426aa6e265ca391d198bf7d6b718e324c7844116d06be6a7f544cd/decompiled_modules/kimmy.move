module 0xba102f4b69426aa6e265ca391d198bf7d6b718e324c7844116d06be6a7f544cd::kimmy {
    struct KIMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMMY>(arg0, 9, b"KIMMY", b"Kim K", b"Kimmy Token (KIMMY) on the Sui blockchain is a playful token fueling a fun, decentralized entertainment world. It lets users unlock exclusive content, earn rewards for engagement, and participate in community-driven decisions, all while enhancing connections between creators and fans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1250446795290755073/m3VlSCFj.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KIMMY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMMY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}


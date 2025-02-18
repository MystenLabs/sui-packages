module 0xeb1afa751aa8c080f195d24c4d93aae067f597a189be89bf6547620d4c0878ea::spikes {
    struct SPIKES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIKES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIKES>(arg0, 9, b"SPIKES", b"Stacy Spikes", b"Tech Founder & CEO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/9Z4GKSp.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPIKES>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIKES>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIKES>>(v1);
    }

    // decompiled from Move bytecode v6
}


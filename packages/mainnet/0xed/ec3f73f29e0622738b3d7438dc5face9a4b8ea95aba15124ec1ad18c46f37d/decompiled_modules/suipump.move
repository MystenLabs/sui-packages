module 0xedec3f73f29e0622738b3d7438dc5face9a4b8ea95aba15124ec1ad18c46f37d::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUMP>(arg0, 9, b"JEAN", b"Jean sui", b"JeanSui is the official wig of the Sui trenches. One man. One blonde bob. Infinite meme potential.Born from pure chaos when a random Google engineer dropped the most unhinged Jean edit the ecosystem has ever seen, $JEAN is the token for every Sui trencher who knows exactly what this is.No roadmap. No utility. Just pure, unfiltered Jean energy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.suipump.org/icons/d07098fa5e19054cf80565bd199691a9.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPUMP>>(0x2::coin::mint<SUIPUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}


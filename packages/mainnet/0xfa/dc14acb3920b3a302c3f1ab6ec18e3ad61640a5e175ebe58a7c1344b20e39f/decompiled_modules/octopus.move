module 0xfadc14acb3920b3a302c3f1ab6ec18e3ad61640a5e175ebe58a7c1344b20e39f::octopus {
    struct OCTOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPUS>(arg0, 9, b"OCTOPUS", b"Octopus", b"Built on SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgdlvr.com/pic/photoresizer.com/20240530-8674/public")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OCTOPUS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}


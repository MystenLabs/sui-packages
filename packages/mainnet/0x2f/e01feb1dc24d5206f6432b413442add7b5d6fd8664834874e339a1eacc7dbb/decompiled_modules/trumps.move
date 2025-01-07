module 0x2fe01feb1dc24d5206f6432b413442add7b5d6fd8664834874e339a1eacc7dbb::trumps {
    struct TRUMPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPS>(arg0, 6, b"TrumpS", b"TrumpS", b"TrumpS is best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmfVAXJpcimaZ8aChdkmoiyH6z2DBg6HEApFC3DMtrbSy5?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPS>>(v2, @0x1a3d47e8e1eb2392c42bfada4ef03fdfe29c8f054d55d9c0104d0bdf931bef95);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPS>>(v1);
    }

    // decompiled from Move bytecode v6
}


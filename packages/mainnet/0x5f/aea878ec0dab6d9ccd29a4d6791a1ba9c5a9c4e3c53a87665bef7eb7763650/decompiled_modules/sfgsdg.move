module 0x5faea878ec0dab6d9ccd29a4d6791a1ba9c5a9c4e3c53a87665bef7eb7763650::sfgsdg {
    struct SFGSDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFGSDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFGSDG>(arg0, 6, b"sfgsdg", b"dgdsfg", b"sdfgdsg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmVo22JSSm1eY79ix3NkfbcbZ9CwskUX3qx7aFJE17j5J1?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SFGSDG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFGSDG>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFGSDG>>(v1);
    }

    // decompiled from Move bytecode v6
}


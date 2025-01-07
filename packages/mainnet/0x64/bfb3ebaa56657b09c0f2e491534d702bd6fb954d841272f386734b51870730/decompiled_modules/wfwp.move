module 0x64bfb3ebaa56657b09c0f2e491534d702bd6fb954d841272f386734b51870730::wfwp {
    struct WFWP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFWP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFWP>(arg0, 6, b"wfwp", b"World Peace", b"May world peace", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmezcWwZxTAo4bn8gpiTHRpUtQYX26KJYJu6try2VntmEg?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WFWP>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFWP>>(v2, @0x29ab5447bcaa887602f2fb3210c9f59f51aa9786af65ad730bfcc7aa84998dd);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WFWP>>(v1);
    }

    // decompiled from Move bytecode v6
}


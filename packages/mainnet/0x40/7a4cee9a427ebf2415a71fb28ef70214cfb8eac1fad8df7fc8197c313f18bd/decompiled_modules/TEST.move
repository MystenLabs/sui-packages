module 0x407a4cee9a427ebf2415a71fb28ef70214cfb8eac1fad8df7fc8197c313f18bd::TEST {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = mint(arg0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST>>(v0);
    }

    public fun mint(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<TEST>, 0x2::coin::CoinMetadata<TEST>) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST3", b"Test", b"Test Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yt3.ggpht.com/a/AATXAJzsHPys1EoSnxprcPapwsQsb1gr97KzKfnRBw=s900-c-k-c0xffffffff-no-rj-mo")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 1000000000000000000, @0xff71d11d4e5fe42f5760a3fddb3265c63ba23a17e98247a18c15dce5a92c2de5, arg1);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}


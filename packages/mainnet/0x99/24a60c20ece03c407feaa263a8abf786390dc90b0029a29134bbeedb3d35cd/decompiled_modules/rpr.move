module 0x9924a60c20ece03c407feaa263a8abf786390dc90b0029a29134bbeedb3d35cd::rpr {
    struct RPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RPR>(arg0, 6, b"RPR", b"RugPullRider", x"52756750756c6c526964657220697320612068756d6f726f7573206d656d6520636f696e207265666572656e63696e672074686520227275672070756c6c22207465726d20696e207468652063727970746f63757272656e637920776f726c642e204974732064657369676e206665617475726573206120636172746f6f6e2063686172616374657220726964696e672061206d61676963206361727065742c207265666c656374696e672074686520616476656e7475726f757320616e64207269736b79206e6174757265206f662063727970746f20696e766573746d656e742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732581991631.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RPR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RPR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x71a8e202ca69d9671e5fd01772402e975662349cd049186751ff0154f973b33e::fcp {
    struct FCP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCP>(arg0, 9, b"FCP", b"First Crypto President", x"4a55535420494e3a2020446f6e616c64205472756d70277320696e61756775726174696f6e2077696c6c20666561747572652074656368206c65616465727320616e642061202243727970746f2042616c6c2220686f6e6f72696e672068696d20617320746865202266697273742063727970746f20707265736964656e742e220d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmduNi1kYsDsqXzxz7KvwazETeMuD1nAiXjUgqaQdczke9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FCP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


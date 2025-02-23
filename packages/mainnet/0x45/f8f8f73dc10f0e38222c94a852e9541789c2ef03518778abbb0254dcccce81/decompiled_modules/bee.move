module 0x45f8f8f73dc10f0e38222c94a852e9541789c2ef03518778abbb0254dcccce81::bee {
    struct BEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEE>(arg0, 6, b"BEE", b"BEE NETWORK", x"426565204e6574776f726b20697320612063727970746f63757272656e6379206d696e696e6720617070206c61756e6368656420696e206c61746520323032302c20616c6c6f77696e6720757365727320746f20e2809c6d696e65e2809d2042656520636f696e73206f6e206d6f62696c652070686f6e65732e20496e206561726c7920323032352c20426565204e6574776f726b20706c616e7320746f206c61756e63682047616d652043656e7465722c2061206e6577204b59432073797374656d2c20616e6420657870616e64206d617373207573657220766572696669636174696f6e2e2041667465722050692057696c6c204c69737420426565", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/364d1aef-8413-4bc5-ae5b-e34d9669cdc2.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


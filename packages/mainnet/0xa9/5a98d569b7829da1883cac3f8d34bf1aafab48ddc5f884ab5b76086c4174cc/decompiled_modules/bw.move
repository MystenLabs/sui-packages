module 0xa95a98d569b7829da1883cac3f8d34bf1aafab48ddc5f884ab5b76086c4174cc::bw {
    struct BW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BW>(arg0, 6, b"BW", b"BlueWaffle", b"Blue waffles... yum yum yum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_10_14_041103964_1f7928c4e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BW>>(v1);
    }

    // decompiled from Move bytecode v6
}


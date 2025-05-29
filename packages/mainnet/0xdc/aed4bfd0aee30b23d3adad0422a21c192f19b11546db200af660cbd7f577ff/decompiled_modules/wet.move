module 0xdcaed4bfd0aee30b23d3adad0422a21c192f19b11546db200af660cbd7f577ff::wet {
    struct WET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WET>(arg0, 6, b"WET", b"WetCat", b"Wet cat is a silly, Fun-loving cat who got caught in the train! This token all about her - She's full of love, laughter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000074941_b8c8d50a1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WET>>(v1);
    }

    // decompiled from Move bytecode v6
}


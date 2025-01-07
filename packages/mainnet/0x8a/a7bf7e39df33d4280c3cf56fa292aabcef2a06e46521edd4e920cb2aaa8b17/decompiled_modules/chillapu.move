module 0x8aa7bf7e39df33d4280c3cf56fa292aabcef2a06e46521edd4e920cb2aaa8b17::chillapu {
    struct CHILLAPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLAPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLAPU>(arg0, 6, b"ChillApu", b"ChillApustaja", x"4368696c6c4170757374616a6120697320796f7572206c6169642d6261636b2063727970746f2062756464792c206865726520746f2076696265207468726f756768207468652077696c64207377696e6773206f6620746865206d61726b65742e205768657468657220796f7527726520484f444c696e672c20464f4d4f696e672c206f72206a75737420646f6467696e67204655442c204368696c6c4170757374616a61206b6565707320697420636f6f6c2e204e6f2070756d702c206e6f2064756d706a75737420766962657320616e64206761696e732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241218_003044_978_aef014705d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLAPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLAPU>>(v1);
    }

    // decompiled from Move bytecode v6
}


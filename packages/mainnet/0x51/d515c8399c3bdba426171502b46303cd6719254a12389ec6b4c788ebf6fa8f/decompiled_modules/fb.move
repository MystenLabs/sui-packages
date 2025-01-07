module 0x51d515c8399c3bdba426171502b46303cd6719254a12389ec6b4c788ebf6fa8f::fb {
    struct FB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FB>(arg0, 6, b"FB", b"FaceBook Button", b"Facebook needs three button. 'Like', 'Dislike', and 'Stop being stupid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/like_c4e60e2675.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FB>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xcf06f3286080e0d03bf6e6773f3efe32496b8e29d2aeb6fa85eecbf997147004::gulf {
    struct GULF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GULF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GULF>(arg0, 6, b"GULF", b"GREAT UNITED LEADING FAMILY", x"436f756e7472696573207468617420626f7264657220746865205065727369616e2047756c662061726520726566657272656420746f2061732067756c6620636f756e74726965732e204261687261696e2c204b75776169742c20497261712c204f6d616e2c2051617461722c205361756469204172616269612c20556e69746564204172616220456d6972617465732061726520746865206e616d6573206f6620736576656e2067756c6620636f756e74726965732e200a0a544f47455448455220414c4c2041524520475245415420554e49544544204c454144494e472046414d494c59", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000078217_1ff4018098.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GULF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GULF>>(v1);
    }

    // decompiled from Move bytecode v6
}


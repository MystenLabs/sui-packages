module 0x5c3221787e76a856836742675d7cda845b49f0d38577570b3e689009be586a::carl {
    struct CARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARL>(arg0, 9, b"Carl", b"Brutanadilewski", x"497420646f6e2774206d61747465722e204e6f6e65206f662074686973206d6174746572732e0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b6a408d92603f76dbdee6195d75142efblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CARL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xe0d34d646c5c29a071268771f8d2609ff5a274b71aa9540d1ea7c8c3e7c9cddc::wtf {
    struct WTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTF>(arg0, 9, b"WTF", b"WHAT THE FUCK?", b"WHAT THE FUCK? Moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.istockphoto.com/id/1444180095/vector/wtf-speech-bubble-in-color-pop-art-style-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=mMmxSQogXtCLLgBJtKMkqolkNTKxV-cx9lR1YDSbvUg=")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WTF>(&mut v2, 33333000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTF>>(v1);
    }

    // decompiled from Move bytecode v6
}


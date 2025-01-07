module 0xb670b32e29379136c51d58f4b67fdbe1c0d973bfead4362a4ebdefbc4f245087::wtf {
    struct WTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTF>(arg0, 9, b"WTF", b"WHAT THE FUCK", b"WHAT THE FUCK?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.istockphoto.com/id/1444180095/vector/wtf-speech-bubble-in-color-pop-art-style-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=mMmxSQogXtCLLgBJtKMkqolkNTKxV-cx9lR1YDSbvUg=")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WTF>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTF>>(v1);
    }

    // decompiled from Move bytecode v6
}


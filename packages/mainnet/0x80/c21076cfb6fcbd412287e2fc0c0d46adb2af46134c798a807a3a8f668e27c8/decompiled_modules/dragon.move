module 0x80c21076cfb6fcbd412287e2fc0c0d46adb2af46134c798a807a3a8f668e27c8::dragon {
    struct DRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGON>(arg0, 6, b"DRAGON", b"SUI WATER DRAGON", b"Sui Ecosystem Rise, Check Out the Current Popular \"Water Meme\" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/941c8f524503d510c903d415bac4279a1727232901967_9252d989cc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}


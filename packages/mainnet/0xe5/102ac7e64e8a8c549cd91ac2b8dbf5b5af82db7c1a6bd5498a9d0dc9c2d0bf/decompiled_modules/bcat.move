module 0xe5102ac7e64e8a8c549cd91ac2b8dbf5b5af82db7c1a6bd5498a9d0dc9c2d0bf::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCAT>(arg0, 6, b"BCAT", b"Banana Cat", x"4361742042616e616e6120697320612066756e20616e6420717569726b79204d454d4520696e20776869636820796f752077696c6c206265636f6d65206120636f6f6c20636174206f7220646f672077656172696e6720612062616e616e6120737569740a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catclub_4a19f7f2a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


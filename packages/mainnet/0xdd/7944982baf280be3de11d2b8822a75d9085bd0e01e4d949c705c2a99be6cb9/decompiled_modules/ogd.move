module 0xdd7944982baf280be3de11d2b8822a75d9085bd0e01e4d949c705c2a99be6cb9::ogd {
    struct OGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGD>(arg0, 9, b"OGD", b"OG DOLLARS", b"OGD is a project that comes to make a big surprise in SUI Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7d2f501b46d36fcd6e6b4fb0979ceab4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


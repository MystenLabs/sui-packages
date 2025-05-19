module 0x8948009b38e738bebaec033bad9130f0687652a77e515e5e4e0e23a545e78fdd::mhaygfsf {
    struct MHAYGFSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHAYGFSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHAYGFSF>(arg0, 9, b"Mhaygfsf", b"8888", b"666", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0180c2882fad70e56ba45cbfc8f1ee8bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MHAYGFSF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHAYGFSF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


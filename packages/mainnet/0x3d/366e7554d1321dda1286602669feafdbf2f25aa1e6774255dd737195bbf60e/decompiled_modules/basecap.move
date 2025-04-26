module 0x3d366e7554d1321dda1286602669feafdbf2f25aa1e6774255dd737195bbf60e::basecap {
    struct BASECAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASECAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASECAP>(arg0, 9, b"BaseCap", b"Base Captain ", b"Hello base is for everyone ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e9a16d5151bb5e0c1d37946ddd75bc5bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BASECAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASECAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


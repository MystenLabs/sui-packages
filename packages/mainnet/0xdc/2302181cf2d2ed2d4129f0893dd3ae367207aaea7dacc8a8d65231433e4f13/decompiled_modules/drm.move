module 0xdc2302181cf2d2ed2d4129f0893dd3ae367207aaea7dacc8a8d65231433e4f13::drm {
    struct DRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRM>(arg0, 9, b"DRM", b"dream", x"4a55535420464f522054524144c4b04e47", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c4f5a4eb0956bd2363f55115e070e8ceblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xd3d0a1553e0253a8444a28bb2d59d6ab39db25a0dc745ec50da2257fbfee93cd::drm {
    struct DRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRM>(arg0, 9, b"DRM", b"DOREMON", b"go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6a765cf9c2effbfc0f091cd6ea005778blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


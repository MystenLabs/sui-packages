module 0x686ac93bd29452f904ef16b5bc5a3c731b250b4781f1dbada9a3bc66b284287d::fhi {
    struct FHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHI>(arg0, 9, b"FHI", b"fyuil", b"k7yurikfyuk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/df8be058e3181ab16cdd97c6a0ddc332blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


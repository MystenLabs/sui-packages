module 0x783861703261bf414db4d10ea53f1da2362e6d7dc29bc2bdab1334254b93a74f::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAI>(arg0, 6, b"AAI", b"Agent AI", b"Hey Agent AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desktop_wallpaper_PC_4_K_ccdcb11364.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAI>>(v1);
    }

    // decompiled from Move bytecode v6
}


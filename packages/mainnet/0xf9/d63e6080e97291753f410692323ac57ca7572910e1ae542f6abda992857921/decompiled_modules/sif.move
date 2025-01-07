module 0xf9d63e6080e97291753f410692323ac57ca7572910e1ae542f6abda992857921::sif {
    struct SIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIF>(arg0, 6, b"SIF", b"Squirelwifhat", b"Squirrelwifhat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_05_11_02_04_9041020b0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIF>>(v1);
    }

    // decompiled from Move bytecode v6
}


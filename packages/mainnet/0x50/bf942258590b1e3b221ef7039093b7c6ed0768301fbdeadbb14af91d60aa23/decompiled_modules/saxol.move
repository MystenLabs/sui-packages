module 0x50bf942258590b1e3b221ef7039093b7c6ed0768301fbdeadbb14af91d60aa23::saxol {
    struct SAXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAXOL>(arg0, 6, b"SAXOL", b"SuiAxolodl", b"Vision sui meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021998_b4ad6b3d6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xddd2342e914f48a5694b58644b5085676f0c8b3a722150af08a681431f2b600::cheeky {
    struct CHEEKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEKY>(arg0, 6, b"CHEEKY", b"CHEEKY CHEETAH", b"Speed and wit combined, Cheeky Cheetah is the fastest meme in the savanna.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_042151359_adfd3cf59f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEKY>>(v1);
    }

    // decompiled from Move bytecode v6
}


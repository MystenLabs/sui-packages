module 0x2d21103a6ed95b22fbe3b7803c2dd0cfb642a183392b11a5ebccc13744ab28de::sht {
    struct SHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHT>(arg0, 9, b"SHT", b"SHOUT", b"SHT IS A MEMECOIN AND HAS NO UTILITY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://em-content.zobj.net/source/microsoft/378/dizzy-face_1f635.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHT>>(v1);
    }

    // decompiled from Move bytecode v6
}


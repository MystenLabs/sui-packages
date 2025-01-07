module 0x6b5bfdc64426faa71eb27843159ff02d32cc8f6f480fc7fa20d2550eec510c8f::snic {
    struct SNIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIC>(arg0, 6, b"SNIC", b"Suinic", b"Solnic Coin! All aboard the magic school bus! Next stop Jupiter  Swap here ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_73f8d3a00d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIC>>(v1);
    }

    // decompiled from Move bytecode v6
}


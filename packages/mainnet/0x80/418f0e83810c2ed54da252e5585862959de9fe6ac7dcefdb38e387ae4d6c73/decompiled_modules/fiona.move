module 0x80418f0e83810c2ed54da252e5585862959de9fe6ac7dcefdb38e387ae4d6c73::fiona {
    struct FIONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIONA>(arg0, 6, b"FIONA", b"Fiona", b"Fiona on Sui - The most famous Hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_32b859377a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIONA>>(v1);
    }

    // decompiled from Move bytecode v6
}


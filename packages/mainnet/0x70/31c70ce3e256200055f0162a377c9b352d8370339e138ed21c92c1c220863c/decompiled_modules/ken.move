module 0x7031c70ce3e256200055f0162a377c9b352d8370339e138ed21c92c1c220863c::ken {
    struct KEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEN>(arg0, 6, b"Ken", b"Kenji Sui", b"Kenji On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_0983393a44.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


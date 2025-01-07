module 0x966398c49d2df6abe6d3fef31092e5612d596f4b39bff87d632f4dd74e4726ae::nwa {
    struct NWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWA>(arg0, 6, b"NWA", b"Never Work Again", b"THIS IS IT LADS! BULLRUN IS HERE. EASY MODE IS COMING. We will never work again and were all gonna make it. Lock the f in and retire your bloodline. LFG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Mqpxrb_V37dwtw1x8w_Tgyu_F1y_Vqx_Q4wgb_Kmb_Rpgq_Xifs_9c1d619e60.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NWA>>(v1);
    }

    // decompiled from Move bytecode v6
}


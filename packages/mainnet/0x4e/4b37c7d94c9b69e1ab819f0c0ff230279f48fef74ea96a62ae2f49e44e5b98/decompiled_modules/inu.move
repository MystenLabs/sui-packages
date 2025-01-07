module 0x4e4b37c7d94c9b69e1ab819f0c0ff230279f48fef74ea96a62ae2f49e44e5b98::inu {
    struct INU has drop {
        dummy_field: bool,
    }

    fun init(arg0: INU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INU>(arg0, 6, b"INU", b"SUIINU", b"Sui Inu - the water dog of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K3_HE_Jo_X5_400x400_3916da18b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INU>>(v1);
    }

    // decompiled from Move bytecode v6
}


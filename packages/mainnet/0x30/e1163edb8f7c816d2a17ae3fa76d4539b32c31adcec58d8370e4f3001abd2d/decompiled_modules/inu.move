module 0x30e1163edb8f7c816d2a17ae3fa76d4539b32c31adcec58d8370e4f3001abd2d::inu {
    struct INU has drop {
        dummy_field: bool,
    }

    fun init(arg0: INU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INU>(arg0, 6, b"INU", b"Sui INU", b"ui INU taking the power of the Sui community to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiinu_a411e2889b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INU>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x4b073157538ad04389043e71f58647ea53920c47616cfc8d3e3f527beeeec16a::inu {
    struct INU has drop {
        dummy_field: bool,
    }

    fun init(arg0: INU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INU>(arg0, 6, b"Inu", b"inu.png", b"Inu.png is a dog that represents the movement from SOL to Sui. I have full faith that degens will see this to 100M+ Pure organic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6511_55976a579c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INU>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x1f2004faeed800709f00e5e85c3d23cd08ca6870a84f90db289687907a5c59de::dev {
    struct DEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV>(arg0, 6, b"DEV", b"MY DOG IS THE DEV", b"#1 dog $DEV ecosystem in web3, home to all dogs & devs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dog_65881bb028.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEV>>(v1);
    }

    // decompiled from Move bytecode v6
}


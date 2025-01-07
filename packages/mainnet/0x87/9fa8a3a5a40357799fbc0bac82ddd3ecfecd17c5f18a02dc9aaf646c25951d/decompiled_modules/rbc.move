module 0x879fa8a3a5a40357799fbc0bac82ddd3ecfecd17c5f18a02dc9aaf646c25951d::rbc {
    struct RBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBC>(arg0, 9, b"RBC", b"Rubic cube", b"it is just more than a hobby its rubic of life with more token solve it better and practice your brain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81906c3d-af90-4512-ac87-ee90ba15bc12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

